#!/usr/bin/env bash
files="$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"

for file in $files; do
  # convmv 이용하여 파일 이름에서 자소 분리된 파일명을 올바르게 변경
  convmv -f utf-8 -t utf-8 --notest --replace --nfc "$file"
  notify-send "변환 완료" "$file 이름이 변경되었습니다."
done
