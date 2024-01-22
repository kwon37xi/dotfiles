#!/usr/bin/env bash
# 단면 스캔으로 모두 앞에서 부터 스캔한 두개의 파일을 그대로 합치기
if [ "$#" -ne 3 ]; then
    echo "Usage: pdf-merge-forwarded.sh <첫번째.pdf> <두번째.pdf> <결과.pdf>"
fi

pdftk "$1" "$2" cat output "$3"
