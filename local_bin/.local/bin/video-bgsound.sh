#!/usr/bin/env bash
#
# video-bgsound.sh - 동영상의 기존 소리를 제거하고, 선택적으로 배경음악을 입힌다.
#
#  - 사운드 파일을 지정하지 않으면: 오디오 트랙을 제거한 동영상을 만든다.
#  - 사운드 파일을 지정하면: 동영상 길이만큼 사운드를 반복 재생하고,
#    마지막 N초(기본 5초) 동안 페이드 아웃한다.
#  - 사운드 파일과 함께 -k 를 지정하면: 기존 동영상 소리를 유지한 채 배경음악을 섞는다.
#
# 영상 스트림은 재인코딩하지 않고 그대로 복사(-c:v copy)하므로 빠르고 화질 손실이 없다.

set -euo pipefail

PROG=$(basename "$0")
DEFAULT_FADE=5

usage() {
    cat <<EOF
사용법: $PROG [옵션] <입력 동영상> [출력 동영상]

동영상의 소리를 제거한다. -s 로 사운드 파일을 지정하면 해당 사운드를
배경음악으로 동영상 길이만큼 반복 재생하고, 끝부분은 페이드 아웃한다.
기본적으로 기존 동영상 소리는 제거되며, -k 를 주면 기존 소리에 배경음악을 섞는다.

옵션:
  -s, --sound FILE     배경음악으로 사용할 사운드 파일
  -f, --fade SECONDS   끝부분 페이드 아웃 시간(초, 소수 가능). 기본값: ${DEFAULT_FADE}
                       0 이면 페이드 아웃하지 않음
  -v, --volume VOLUME  배경음악 볼륨. 기본값: 원본 사운드 볼륨 그대로
                       예) 0.5 (절반), 1.5 (1.5배), 50% , -6dB, +3dB
  -k, --keep-audio     기존 동영상 소리를 유지하고 배경음악을 섞기 (-s 필요)
  -y, --overwrite      출력 파일이 이미 있으면 덮어쓰기
  -h, --help           이 도움말 출력

출력 파일을 생략하면 '<입력이름>.nosound.<확장자>' 또는
'<입력이름>.bgm.<확장자>' 로 저장한다.

예:
  $PROG input.mp4
  $PROG -s music.mp3 input.mp4 output.mp4
  $PROG -s music.mp3 -f 3 -v 0.3 input.mp4
  $PROG -s music.mp3 -v -10dB input.mp4
  $PROG -s music.mp3 -k -v 0.2 input.mp4
EOF
}

die() {
    echo "$PROG: 오류: $*" >&2
    exit 1
}

# 볼륨 값을 ffmpeg volume 필터 형식으로 변환/검증한다.
normalize_volume() {
    local v=$1
    if [[ $v =~ ^[0-9]+(\.[0-9]+)?%$ ]]; then
        awk -v p="${v%\%}" 'BEGIN { printf "%.4f", p / 100 }'
    elif [[ $v =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        echo "$v"
    elif [[ $v =~ ^[+-]?[0-9]+(\.[0-9]+)?[dD][bB]$ ]]; then
        echo "${v%??}dB"
    else
        return 1
    fi
}

# 출력 확장자에 맞는 오디오 코덱을 고른다.
audio_codec_for() {
    case "${1,,}" in
        webm|ogg|ogv) echo "libopus" ;;
        *)            echo "aac" ;;
    esac
}

SOUND=""
FADE=$DEFAULT_FADE
VOLUME=""
KEEP_AUDIO=false
OVERWRITE="-n"
POSITIONAL=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        -s|--sound)   [[ $# -ge 2 ]] || die "$1 옵션에 값이 필요합니다"; SOUND=$2; shift 2 ;;
        -f|--fade)    [[ $# -ge 2 ]] || die "$1 옵션에 값이 필요합니다"; FADE=$2; shift 2 ;;
        -v|--volume)  [[ $# -ge 2 ]] || die "$1 옵션에 값이 필요합니다"; VOLUME=$2; shift 2 ;;
        -k|--keep-audio) KEEP_AUDIO=true; shift ;;
        -y|--overwrite) OVERWRITE="-y"; shift ;;
        -h|--help)    usage; exit 0 ;;
        --)           shift; POSITIONAL+=("$@"); break ;;
        -*)           die "알 수 없는 옵션: $1 (도움말: $PROG -h)" ;;
        *)            POSITIONAL+=("$1"); shift ;;
    esac
done

[[ ${#POSITIONAL[@]} -ge 1 && ${#POSITIONAL[@]} -le 2 ]] || { usage >&2; exit 1; }

for cmd in ffmpeg ffprobe awk; do
    command -v "$cmd" >/dev/null 2>&1 || die "'$cmd' 명령을 찾을 수 없습니다. 설치해 주세요."
done

INPUT=${POSITIONAL[0]}
[[ -f $INPUT ]] || die "입력 파일이 없습니다: $INPUT"

ext="${INPUT##*.}"
base="${INPUT%.*}"
[[ $ext == "$INPUT" ]] && ext="mp4" && base="$INPUT"

if [[ -n $SOUND ]]; then
    OUTPUT=${POSITIONAL[1]:-"${base}.bgm.${ext}"}
else
    OUTPUT=${POSITIONAL[1]:-"${base}.nosound.${ext}"}
fi

[[ $(realpath -m -- "$INPUT") != $(realpath -m -- "$OUTPUT") ]] \
    || die "입력 파일과 출력 파일이 같을 수 없습니다"
[[ $OVERWRITE == "-y" || ! -e $OUTPUT ]] \
    || die "출력 파일이 이미 존재합니다: $OUTPUT (덮어쓰려면 -y 옵션 사용)"

# 소리만 제거
if [[ -z $SOUND ]]; then
    [[ -n $VOLUME ]] && echo "$PROG: 경고: 사운드 파일이 없으므로 --volume 은 무시됩니다" >&2
    $KEEP_AUDIO && echo "$PROG: 경고: 사운드 파일이 없으므로 --keep-audio 는 무시됩니다" >&2
    ffmpeg -hide_banner -loglevel warning -stats $OVERWRITE \
        -i "$INPUT" \
        -map 0 -map -0:a -c copy \
        "$OUTPUT"
    echo "완료: $OUTPUT (소리 제거)"
    exit 0
fi

# 배경음악 입히기
[[ -f $SOUND ]] || die "사운드 파일이 없습니다: $SOUND"
[[ $FADE =~ ^[0-9]+(\.[0-9]+)?$ ]] || die "페이드 시간은 0 이상의 숫자여야 합니다: $FADE"

VOLUME_FILTER=""
if [[ -n $VOLUME ]]; then
    vol=$(normalize_volume "$VOLUME") || die "잘못된 볼륨 값입니다: $VOLUME (예: 0.5, 50%, -6dB)"
    VOLUME_FILTER="volume=${vol},"
fi

DURATION=$(ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 "$INPUT")
[[ $DURATION =~ ^[0-9]+(\.[0-9]+)?$ ]] || die "동영상 길이를 알 수 없습니다: $INPUT"

# 페이드 시간이 영상보다 길면 영상 전체에 걸쳐 페이드 아웃
read -r FADE_START FADE_DUR < <(awk -v d="$DURATION" -v f="$FADE" \
    'BEGIN { if (f > d) f = d; printf "%.3f %.3f\n", d - f, f }')

FADE_FILTER=""
if awk -v f="$FADE_DUR" 'BEGIN { exit !(f > 0) }'; then
    FADE_FILTER=",afade=t=out:st=${FADE_START}:d=${FADE_DUR}"
fi

FILTER="[1:a]${VOLUME_FILTER}atrim=0:${DURATION},asetpts=PTS-STARTPTS${FADE_FILTER}[bgm]"
AOUT="[bgm]"
MODE="배경음악으로 교체"

if $KEEP_AUDIO; then
    if [[ -n $(ffprobe -v error -select_streams a -show_entries stream=index -of csv=p=0 "$INPUT") ]]; then
        # 원본 소리와 배경음악을 각각 원래 크기 그대로 섞는다(normalize=0).
        # 원본 오디오가 영상보다 짧아도 배경음악은 끝까지 이어지도록 duration=longest.
        FILTER+=";[0:a:0][bgm]amix=inputs=2:duration=longest:dropout_transition=0:normalize=0[mix]"
        AOUT="[mix]"
        MODE="원본 소리 + 배경음악"
    else
        echo "$PROG: 경고: 동영상에 오디오 트랙이 없어 배경음악만 넣습니다" >&2
    fi
fi

ffmpeg -hide_banner -loglevel warning -stats $OVERWRITE \
    -i "$INPUT" \
    -stream_loop -1 -i "$SOUND" \
    -filter_complex "$FILTER" \
    -map 0:v -map "$AOUT" -map 0:s? \
    -c:v copy -c:s copy -c:a "$(audio_codec_for "${OUTPUT##*.}")" -b:a 192k \
    -t "$DURATION" \
    "$OUTPUT"

echo "완료: $OUTPUT (${MODE}, 배경음악: $SOUND, 길이: ${DURATION}s, 페이드 아웃: ${FADE_DUR}s${VOLUME:+, 볼륨: $VOLUME})"
