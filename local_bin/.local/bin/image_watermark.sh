#!/usr/bin/env bash
#
# image_watermark.sh - 이미지 파일에 텍스트 워터마크를 넣는다. (ffmpeg / ffprobe / fontconfig 필요)
#
# 사용법:
#   image_watermark.sh -w 텍스트 [-p 위치] [-F 폰트] [-S pt] [-C 색상] [-B 색상] [-o 출력] [-y] <입력이미지>...
#
# 옵션:
#   -w 텍스트 워터마크로 넣을 텍스트. 필수.
#   -p 위치  워터마크 위치. topleft, topright, bottomleft, bottomright 중 하나. 기본 bottomright.
#   -F 폰트  워터마크 폰트(fontconfig 폰트명, fc-list 로 확인). 스타일은 '이름:style=Bold' 처럼 지정.
#            기본 NanumSquareRound ExtraBold.
#   -S pt    워터마크 글자 크기(pt, 96 DPI 기준으로 px 변환). 기본은 이미지 높이의 1/18 px (최소 12px).
#   -C 색상  워터마크 글자 색상. RRGGBB 16진수(#D9B289, 0xD9B289, D9B289 형식).
#            기본 #D9B289 (베이지, 약간 투명).
#   -B 색상  워터마크 글자 테두리 색상. RRGGBB 16진수(-C 와 같은 형식). 기본 #000000 (검정, 반투명).
#   -o 출력, --output 출력
#            출력 파일 경로. 입력 이미지가 하나일 때만 쓸 수 있다.
#            생략하면 입력 파일명의 확장자 앞에 -watermarked 를 붙인 이름으로 같은 디렉터리에 만든다.
#            (예: photo.jpg -> photo-watermarked.jpg)
#   -y       출력 파일이 이미 존재하면 덮어쓴다. 지정하지 않으면 그 파일은 건너뛰고 오류로 처리한다.
#   -h, --help 도움말
#
# 입력 이미지는 여러 개 지정할 수 있으며, 일부가 실패해도 나머지는 계속 처리한 뒤 실패가 있으면 1 로 종료한다.
# 출력 형식은 출력 파일 확장자로 정한다(png, jpg, webp 등). 출력이 .gif 면 팔레트를 새로 만들어
# 색 품질을 유지하며, 움직이는 GIF 는 모든 프레임에 워터마크를 넣는다.
#
set -euo pipefail

DEFAULT_POSITION=bottomright
DEFAULT_FONT='NanumSquareRound ExtraBold'
DEFAULT_TEXT_COLOR='#D9B289'
DEFAULT_BORDER_COLOR='#000000'
OUTPUT_SUFFIX=-watermarked

usage() {
  sed -n '3,27p' "$0" | sed 's/^# \{0,1\}//'
}

die() {
  echo "오류: $*" >&2
  exit 1
}

watermark=
position=$DEFAULT_POSITION
font=$DEFAULT_FONT
font_pt=
text_color=$DEFAULT_TEXT_COLOR
border_color=$DEFAULT_BORDER_COLOR
output=
overwrite=false

# getopts 는 긴 옵션을 지원하지 않으므로 짧은 옵션으로 바꿔 넘긴다. -- 뒤는 모두 입력 이미지로 본다.
args=()
inputs=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --output) args+=(-o) ;;
    --output=*) args+=(-o "${1#--output=}") ;;
    --help) args+=(-h) ;;
    --) shift; inputs+=("$@"); break ;;
    --*) die "알 수 없는 옵션: $1" ;;
    *) args+=("$1") ;;
  esac
  shift
done
set -- "${args[@]+"${args[@]}"}"

# 옵션이 입력 이미지 뒤에 와도 받도록, getopts 가 멈춘 자리의 입력을 모으고 다시 파싱한다.
positional=()
while [[ $# -gt 0 ]]; do
  OPTIND=1
  while getopts ":w:p:F:S:C:B:o:yh" opt; do
    case "$opt" in
      w) watermark=$OPTARG ;;
      p) position=$OPTARG ;;
      F) font=$OPTARG ;;
      S) font_pt=$OPTARG ;;
      C) text_color=$OPTARG ;;
      B) border_color=$OPTARG ;;
      o) output=$OPTARG ;;
      y) overwrite=true ;;
      h) usage; exit 0 ;;
      :) die "-$OPTARG 옵션에 값이 필요합니다." ;;
      \?) die "알 수 없는 옵션: -$OPTARG" ;;
    esac
  done
  shift $(( OPTIND - 1 ))
  if [[ $# -gt 0 ]]; then
    positional+=("$1")
    shift
  fi
done
set -- "${positional[@]+"${positional[@]}"}" "${inputs[@]+"${inputs[@]}"}"

if [[ $# -lt 1 ]]; then
  usage >&2
  exit 1
fi
if [[ -n "$output" && $# -gt 1 ]]; then
  die "출력 파일(-o, --output)은 입력 이미지가 하나일 때만 지정할 수 있습니다."
fi

for cmd in ffmpeg ffprobe fc-list fc-match; do
  command -v "$cmd" >/dev/null 2>&1 || die "$cmd 명령을 찾을 수 없습니다. ffmpeg 와 fontconfig 를 설치해주세요."
done

[[ -n "$watermark" ]] || die "워터마크 텍스트(-w)를 지정해야 합니다."
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
if [[ -n "$font_pt" ]]; then
  [[ "$font_pt" =~ ^[0-9]+([.][0-9]+)?$ ]] && awk -v p="$font_pt" 'BEGIN { exit !(p > 0) }' \
    || die "워터마크 글자 크기(-S)는 0 보다 큰 숫자(pt)여야 합니다: $font_pt"
fi

# 텍스트는 파일로 넘겨 filtergraph 이스케이프 문제를 피한다.
text_file=$(mktemp)
trap 'rm -f "$text_file"' EXIT
printf '%s' "$watermark" > "$text_file"

if $overwrite; then overwrite_flag=-y; else overwrite_flag=-n; fi

# 입력 파일명의 확장자 앞에 접미사를 붙인 출력 경로.
# 디렉터리 이름의 . 이나 숨김 파일의 맨 앞 . 은 확장자로 보지 않는다.
default_output() {
  local dir name
  dir=$(dirname -- "$1")
  name=$(basename -- "$1")
  if [[ "$name" == ?*.* ]]; then
    echo "${dir}/${name%.*}${OUTPUT_SUFFIX}.${name##*.}"
  else
    echo "${dir}/${name}${OUTPUT_SUFFIX}"
  fi
}

# 이미지 하나에 워터마크를 넣는다. 실패하면 오류를 출력하고 1 을 반환한다.
watermark_one() {
  local input=$1 output=$2
  local height margin font_size border x y filters output_ext
  local -a out_opts

  # - 로 시작하는 파일명을 ffmpeg 가 옵션으로 읽지 않게 한다.
  [[ "$input" == -* ]] && input=./$input
  [[ "$output" == -* ]] && output=./$output

  if [[ ! -f "$input" ]]; then
    echo "오류: 입력 파일이 존재하지 않습니다: $input" >&2; return 1
  fi
  if [[ -d "$output" ]]; then
    echo "오류: 출력 경로가 디렉터리입니다: $output" >&2; return 1
  fi
  if [[ -e "$output" ]] && ! $overwrite; then
    echo "오류: 출력 파일이 이미 존재합니다(덮어쓰려면 -y): $output" >&2; return 1
  fi

  # 원본 이미지 높이 조회
  height=$(ffprobe -v error -select_streams v:0 -show_entries stream=height \
    -of default=noprint_wrappers=1:nokey=1 "$input" | head -n1) || true
  if ! [[ "$height" =~ ^[0-9]+$ ]] || (( height == 0 )); then
    echo "오류: 이미지를 읽을 수 없습니다: $input" >&2; return 1
  fi

  margin=$(( height / 30 > 4 ? height / 30 : 4 ))
  if [[ -n "$font_pt" ]]; then
    # pt -> px (96 DPI: 1pt = 96/72 px)
    font_size=$(awk -v p="$font_pt" 'BEGIN { n = int(p * 96 / 72 + 0.5); print (n < 1 ? 1 : n) }')
  else
    font_size=$(( height / 18 > 12 ? height / 18 : 12 ))
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

  filters="[0:v]drawtext=${font_opt}:textfile='${text_file}':expansion=none:fontsize=${font_size}:fontcolor=0x${text_hex}@0.85:borderw=${border}:bordercolor=0x${border_hex}@0.6:x=${x}:y=${y}[v]"

  output_ext=$(tr '[:upper:]' '[:lower:]' <<< "${output##*.}")
  if [[ "$output_ext" == gif ]]; then
    # 워터마크 색이 기존 팔레트에 없으므로 팔레트를 새로 만들어 적용한다. 움직이는 GIF 도 그대로 유지.
    filters+=";[v]split[s0][s1];[s0]palettegen=stats_mode=diff[p];[s1][p]paletteuse=dither=sierra2_4a[v]"
    out_opts=(-loop 0)
  else
    # 단일 이미지로 저장 (JPEG 는 고품질)
    out_opts=(-frames:v 1 -update 1)
    [[ "$output_ext" == jpg || "$output_ext" == jpeg ]] && out_opts+=(-q:v 2)
  fi

  echo "워터마크: $input -> $output (${position}, ${font}, ${font_size}px)" >&2

  if ! ffmpeg -hide_banner -loglevel error -nostdin "$overwrite_flag" \
      -i "$input" -filter_complex "$filters" -map '[v]' "${out_opts[@]}" "$output"; then
    echo "오류: 변환에 실패했습니다: $input" >&2; return 1
  fi

  echo "완료: $output" >&2
}

failed=0
for input in "$@"; do
  watermark_one "$input" "${output:-$(default_output "$input")}" || failed=$(( failed + 1 ))
done

if (( failed > 0 )); then
  echo "실패: 전체 $# 개 중 ${failed} 개" >&2
  exit 1
fi
