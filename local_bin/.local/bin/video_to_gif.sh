#!/usr/bin/env bash
#
# video_to_gif.sh - 동영상의 일부 구간을 GIF 로 변환한다. (ffmpeg / ffprobe 필요)
#
# 사용법:
#   video_to_gif.sh [-q 높이] [-f fps] [-b 횟수] [-c 색상] [-s 크기] [-w 텍스트] [-p 위치] [-F 폰트] [-S pt] [-C 색상] [-B 색상] [-y] <입력동영상> <시작ms> <길이ms> <출력.gif>
#
# 옵션:
#   -q 높이  출력 GIF 의 세로 해상도(px). ffmpeg scale 필터 방식(가로는 비율 유지).
#            기본 480 (240/360/480/720/1080 중 중간값).
#            원본 동영상 높이보다 크게 지정하면 원본 높이로 맞춘다.
#   -f fps   출력 GIF 의 초당 프레임 수. 기본 5. 원본 fps 보다 크면 원본 fps 로 맞춘다.
#   -b 횟수  GIF 시작 시 좌측 상단에 재생(⏩) 아이콘을 깜빡일 횟수. 기본 5. 0 이면 표시 안 함.
#   -c 색상  재생 아이콘 색상. RRGGBB 16진수(#D9B289, 0xD9B289, D9B289 형식).
#            기본 #D9B289 (베이지).
#   -s 크기  재생 아이콘 크기(px, 정사각형 한 변, 8 이상). 기본은 출력 높이의 1/8 (최소 16).
#            화면(출력 높이 - 상하 여백)보다 크면 들어가는 최대 크기로 맞춘다.
#   -w 텍스트 워터마크로 넣을 텍스트. 지정하지 않으면 워터마크 없음.
#   -p 위치  워터마크 위치. topleft, topright, bottomleft, bottomright 중 하나. 기본 bottomright.
#   -F 폰트  워터마크 폰트(fontconfig 폰트명, fc-list 로 확인). 스타일은 '이름:style=Bold' 처럼 지정.
#            기본 NanumSquareRound ExtraBold.
#   -S pt    워터마크 글자 크기(pt, 96 DPI 기준으로 px 변환). 기본은 출력 높이의 1/18 px (최소 12px).
#   -C 색상  워터마크 글자 색상. RRGGBB 16진수(-c 와 같은 형식). 기본 #D9B289 (베이지, 약간 투명).
#   -B 색상  워터마크 글자 테두리 색상. RRGGBB 16진수(-c 와 같은 형식). 기본 #000000 (검정, 반투명).
#   -y       출력 파일이 이미 존재하면 덮어쓴다. 지정하지 않으면 변환 전에 오류로 종료.
#   -h       도움말
#
set -euo pipefail

DEFAULT_QUALITY=480
DEFAULT_FPS=5
DEFAULT_BLINKS=5
DEFAULT_ICON_COLOR='#D9B289'
DEFAULT_POSITION=bottomright
DEFAULT_FONT='NanumSquareRound ExtraBold'
DEFAULT_TEXT_COLOR='#D9B289'
DEFAULT_BORDER_COLOR='#000000'

usage() {
  sed -n '3,27p' "$0" | sed 's/^# \{0,1\}//'
}

die() {
  echo "오류: $*" >&2
  exit 1
}

is_uint() {
  [[ "$1" =~ ^[0-9]+$ ]]
}

# ms -> ffmpeg 용 초 문자열 (예: 1500 -> 1.500)
ms_to_sec() {
  printf '%d.%03d' $(( $1 / 1000 )) $(( $1 % 1000 ))
}

quality=$DEFAULT_QUALITY
fps=$DEFAULT_FPS
blinks=$DEFAULT_BLINKS
icon_color=$DEFAULT_ICON_COLOR
icon_size=
watermark=
position=$DEFAULT_POSITION
font=$DEFAULT_FONT
font_pt=
text_color=$DEFAULT_TEXT_COLOR
border_color=$DEFAULT_BORDER_COLOR
overwrite=false

while getopts ":q:f:b:c:s:w:p:F:S:C:B:yh" opt; do
  case "$opt" in
    q) quality=$OPTARG ;;
    f) fps=$OPTARG ;;
    b) blinks=$OPTARG ;;
    c) icon_color=$OPTARG ;;
    s) icon_size=$OPTARG ;;
    w) watermark=$OPTARG ;;
    p) position=$OPTARG ;;
    F) font=$OPTARG ;;
    S) font_pt=$OPTARG ;;
    C) text_color=$OPTARG ;;
    B) border_color=$OPTARG ;;
    y) overwrite=true ;;
    h) usage; exit 0 ;;
    :) die "-$OPTARG 옵션에 값이 필요합니다." ;;
    \?) die "알 수 없는 옵션: -$OPTARG" ;;
  esac
done
shift $(( OPTIND - 1 ))

if [[ $# -ne 4 ]]; then
  usage >&2
  exit 1
fi

input=$1
start_ms=$2
duration_ms=$3
output=$4

for cmd in ffmpeg ffprobe; do
  command -v "$cmd" >/dev/null 2>&1 || die "$cmd 명령을 찾을 수 없습니다. ffmpeg 를 설치해주세요."
done

[[ -f "$input" ]] || die "입력 파일이 존재하지 않습니다: $input"
[[ -d "$output" ]] && die "출력 경로가 디렉터리입니다: $output"
if [[ -e "$output" ]] && ! $overwrite; then
  die "출력 파일이 이미 존재합니다(덮어쓰려면 -y): $output"
fi
is_uint "$start_ms" || die "시작 시점(ms)은 0 이상의 정수여야 합니다: $start_ms"
is_uint "$duration_ms" && (( duration_ms > 0 )) || die "길이(ms)는 1 이상의 정수여야 합니다: $duration_ms"
is_uint "$quality" && (( quality > 0 )) || die "퀄리티(-q)는 1 이상의 정수여야 합니다: $quality"
[[ "$fps" =~ ^[0-9]+([.][0-9]+)?$ ]] && awk -v f="$fps" 'BEGIN { exit !(f > 0) }' \
  || die "fps(-f)는 0 보다 큰 숫자여야 합니다: $fps"
is_uint "$blinks" || die "깜빡임 횟수(-b)는 0 이상의 정수여야 합니다: $blinks"
[[ "$icon_color" =~ ^(#|0[xX])?([0-9a-fA-F]{6})$ ]] \
  || die "아이콘 색상(-c)은 RRGGBB 16진수여야 합니다(예: #D9B289): $icon_color"
icon_hex=${BASH_REMATCH[2]}
if [[ -n "$icon_size" ]]; then
  is_uint "$icon_size" && (( icon_size >= 8 )) || die "아이콘 크기(-s)는 8 이상의 정수여야 합니다: $icon_size"
fi
[[ "$text_color" =~ ^(#|0[xX])?([0-9a-fA-F]{6})$ ]] \
  || die "워터마크 색상(-C)은 RRGGBB 16진수여야 합니다(예: #D9B289): $text_color"
text_hex=${BASH_REMATCH[2]}
[[ "$border_color" =~ ^(#|0[xX])?([0-9a-fA-F]{6})$ ]] \
  || die "워터마크 테두리 색상(-B)은 RRGGBB 16진수여야 합니다(예: #000000): $border_color"
border_hex=${BASH_REMATCH[2]}
case "$position" in
  topleft|topright|bottomleft|bottomright) ;;
  *) die "워터마크 위치(-p)는 topleft, topright, bottomleft, bottomright 중 하나여야 합니다: $position" ;;
esac
if [[ -n "$watermark" ]]; then
  for cmd in fc-list fc-match; do
    command -v "$cmd" >/dev/null 2>&1 || die "$cmd 명령을 찾을 수 없습니다. fontconfig 를 설치해주세요."
  done
  [[ -n "$(fc-list "$font" family)" ]] || die "폰트를 찾을 수 없습니다(fc-list 로 확인): $font"
  # drawtext 의 font= 는 값 전체를 패밀리 이름으로만 취급해 '이름:style=Bold' 같은 패턴이 무시되므로,
  # fontconfig 로 실제 폰트 파일을 찾아 fontfile= 로 넘긴다.
  font_file=$(fc-match -f '%{file}' "$font")
  font_index=$(fc-match -f '%{index}' "$font")
  font_family=$(fc-match -f '%{family[0]}' "$font")
  if [[ "$font_index" == 0 ]]; then
    font_opt="fontfile='${font_file//:/\\:}'"
    [[ "$font_file" != *\'* ]] || die "폰트 파일 경로에 ' 를 쓸 수 없습니다: $font_file"
  else
    # 폰트 모음(.ttc)의 두 번째 이후 폰트는 fontfile= 로 고를 수 없어 패밀리 이름으로 지정한다.
    if [[ "$font" == *:* ]]; then
      echo "알림: $font 은(는) 폰트 모음(.ttc) 안의 폰트라 스타일을 적용할 수 없어 '$font_family' 로 지정합니다." >&2
    else
      font_family=$font
    fi
    [[ "$font_family" != *[\'\\]* ]] || die "폰트 이름에 ' 또는 \\ 를 쓸 수 없습니다: $font_family"
    font_opt="font='${font_family//:/\\:}'"
  fi
fi
if [[ -n "$font_pt" ]]; then
  [[ "$font_pt" =~ ^[0-9]+([.][0-9]+)?$ ]] && awk -v p="$font_pt" 'BEGIN { exit !(p > 0) }' \
    || die "워터마크 글자 크기(-S)는 0 보다 큰 숫자(pt)여야 합니다: $font_pt"
fi

# 원본 동영상 정보 조회
probe() {
  ffprobe -v error -select_streams v:0 -show_entries "$1" -of default=noprint_wrappers=1:nokey=1 "$input" | head -n1
}

src_height=$(probe stream=height) || true
[[ -n "$src_height" ]] || die "동영상 스트림을 읽을 수 없습니다: $input"
src_fps=$(probe stream=avg_frame_rate)
[[ "$src_fps" == "0/0" || -z "$src_fps" ]] && src_fps=$(probe stream=r_frame_rate)
src_duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input" || true)

if [[ "$src_duration" =~ ^[0-9.]+$ ]]; then
  awk -v s="$start_ms" -v d="$src_duration" 'BEGIN { exit !(s / 1000 < d) }' \
    || die "시작 시점(${start_ms}ms)이 동영상 길이(${src_duration}s)를 벗어납니다."
fi

if (( quality > src_height )); then
  echo "알림: 퀄리티 ${quality} 이(가) 원본 높이 ${src_height} 보다 커서 ${src_height} 로 조정합니다." >&2
  quality=$src_height
fi

if [[ "$src_fps" =~ ^[0-9]+(/[0-9]+)?$ ]]; then
  src_fps_dec=$(awk -v r="$src_fps" 'BEGIN { n = split(r, a, "/"); v = (n == 2 && a[2] > 0) ? a[1] / a[2] : a[1]; printf "%.3f", v }')
  if awk -v f="$fps" -v s="$src_fps_dec" 'BEGIN { exit !(s > 0 && f > s) }'; then
    echo "알림: fps ${fps} 이(가) 원본 fps ${src_fps_dec} 보다 커서 ${src_fps_dec} 로 조정합니다." >&2
    fps=$src_fps_dec
  fi
fi

start_sec=$(ms_to_sec "$start_ms")
duration_sec=$(ms_to_sec "$duration_ms")

# 팔레트를 생성해 바로 적용하는 단일 패스 변환 (색 품질 향상)
filters="[0:v]fps=${fps},scale=-1:${quality}:flags=lanczos[v]"

margin=$(( quality / 30 > 4 ? quality / 30 : 4 ))
if [[ -n "$icon_size" ]]; then
  box=$icon_size
  max_box=$(( quality - margin * 2 ))
  if (( box > max_box )); then
    echo "알림: 아이콘 크기 ${box} 이(가) 화면(높이 ${quality} - 여백)보다 커서 ${max_box} 로 조정합니다." >&2
    box=$max_box
  fi
else
  box=$(( quality / 8 > 16 ? quality / 8 : 16 ))
fi

if (( blinks > 0 )); then
  # 재생(⏩) 아이콘: 반투명 검정 상자 위에 지정 색상의 삼각형 두 개를 geq 로 직접 그린다. (폰트 불필요)
  pad=$(( box / 5 ))
  half=$(( (box - 2 * pad) / 2 ))
  # x0 에서 시작해 오른쪽을 가리키는 삼각형 내부 여부
  tri() { echo "between(X-${pad},$1,$1+${half})*lte(abs(Y-${pad}-${half}),${half}*(1-(X-${pad}-$1)/${half}))"; }
  icon="gt($(tri 0)+$(tri "$half"),0)"
  # 깜빡임 1회 = 켜짐 약 0.25초 + 꺼짐 같은 시간 (프레임 단위로 맞춤)
  on_frames=$(awk -v f="$fps" 'BEGIN { n = int(f * 0.25 + 0.5); print (n < 1 ? 1 : n) }')
  cycle=$(( on_frames * 2 ))
  icon_r=$(( 16#${icon_hex:0:2} ))
  icon_g=$(( 16#${icon_hex:2:2} ))
  icon_b=$(( 16#${icon_hex:4:2} ))
  filters+=";color=c=black@0:s=${box}x${box}:r=1:d=1,format=rgba,geq=r='${icon_r}*${icon}':g='${icon_g}*${icon}':b='${icon_b}*${icon}':a='if(${icon},255,180)'[icon]"
  filters+=";[v][icon]overlay=x=${margin}:y=${margin}:enable='lt(n,${blinks}*${cycle})*lt(mod(n,${cycle}),${on_frames})'[v]"
fi

if [[ -n "$watermark" ]]; then
  # 텍스트는 파일로 넘겨 filtergraph 이스케이프 문제를 피한다.
  text_file=$(mktemp)
  trap 'rm -f "$text_file"' EXIT
  printf '%s' "$watermark" > "$text_file"
  if [[ -n "$font_pt" ]]; then
    # pt -> px (96 DPI: 1pt = 96/72 px)
    font_size=$(awk -v p="$font_pt" 'BEGIN { n = int(p * 96 / 72 + 0.5); print (n < 1 ? 1 : n) }')
  else
    font_size=$(( quality / 18 > 12 ? quality / 18 : 12 ))
  fi
  border=$(( font_size / 12 > 1 ? font_size / 12 : 1 ))
  case "$position" in
    *left)  x=$margin ;;
    *right) x="w-tw-${margin}" ;;
  esac
  case "$position" in
    top*)    y=$margin ;;
    bottom*) y="h-th-${margin}" ;;
  esac
  # 좌측 상단은 재생 아이콘 자리이므로 아이콘 아래로 내린다.
  if [[ "$position" == topleft ]] && (( blinks > 0 )); then
    y=$(( margin * 2 + box ))
  fi
  filters+=";[v]drawtext=${font_opt}:textfile='${text_file}':expansion=none:fontsize=${font_size}:fontcolor=0x${text_hex}@0.85:borderw=${border}:bordercolor=0x${border_hex}@0.6:x=${x}:y=${y}[v]"
fi

filters+=";[v]split[s0][s1];[s0]palettegen=stats_mode=diff[p];[s1][p]paletteuse=dither=sierra2_4a"

echo "변환: $input [${start_sec}s ~ +${duration_sec}s] -> $output (높이 ${quality}px, ${fps}fps, 깜빡임 ${blinks}회${watermark:+, 워터마크 ${position}/${font}})" >&2

if $overwrite; then overwrite_flag=-y; else overwrite_flag=-n; fi

ffmpeg -hide_banner -loglevel error -nostdin "$overwrite_flag" \
  -ss "$start_sec" -t "$duration_sec" -i "$input" \
  -filter_complex "$filters" -loop 0 "$output"

echo "완료: $output" >&2
