#!/usr/bin/env bash
#files="$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS"

# 각 파일 처리
for file in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS; do
    target_path=$(basename "$file")
    unzip -O cp949 -d "$target_path" "$file"
    notify-send "unzip-kr succeeded : " "$file"
done
