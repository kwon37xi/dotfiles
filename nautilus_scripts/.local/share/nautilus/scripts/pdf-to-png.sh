#!/usr/bin/env bash
#files="$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"

# 각 파일 처리
for file in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS; do
    target_path=$(basename "$file")
    unzip -O cp949 -d "$target_path" "$file"
    cd "$target_path"
    # file_to_png 는 이미지 파일의 prefix
    pdftoppm -png "$file" "${file}_to_png"
    notify-send "PDF를 png 파일로 완료 : " "$file"
done
