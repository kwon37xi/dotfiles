#!/usr/bin/env bash
# 단면 스캔으로 하나는 앞에서 부터 하나는 뒤에서부터 스캔된  PDF 파일 두개를 올바른 순서로 합쳐준다.
if [ "$#" -ne 3 ]; then
    echo "Usage: pdf-merge-backwarded.sh <앞면스캔.pdf> <뒷면스캔.pdf> <결과.pdf>"
fi

pdftk A="$1" B="$2" shuffle A Bend-1 output "$3"
