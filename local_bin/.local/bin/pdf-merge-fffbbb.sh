#!/usr/bin/env bash
# 단면 스캔으로 두번에 나눠서
# 앞면_첫번째, 앞면_두번째, 뒷면_두번째, 뒷면_첫번째 순서인
# 경우에 대해서 일괄 합치기

if [ "$#" -ne 7 ]; then
    echo "Usage: pdf-merge-ffbb.sh <앞면3개> <뒷면3개> <결과.pdf>"
fi

pdftk "$1" "$2" "$3" cat output "__f.pdf"
pdftk "$4" "$5" "$6" cat output "__b.pdf"

pdftk A="__f.pdf" B="__b.pdf" shuffle A Bend-1 output "$7"
