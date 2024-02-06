#!/bin/bash

# 현재 선택된 파일 목록
files="$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"

# 각 파일 처리
for file in $files; do
  # 파일 확장자 추출
  ext="${file##*.}"

  # JPG 파일인 경우
  if [ "$ext" = "jpg" ]; then
    # PNG 파일 이름 생성
    new_file="${file%.*}.png"

    # 변환 명령 실행
    convert "$file" "$new_file"

    # 변환 성공 알림
    notify-send "변환 완료" "$file -> $new_file"
  fi
done
