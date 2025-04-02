#!/usr/bin/env bash
# pdf-opt.sh 원본.pdf
# 결과는 원본.opt.pdf
# alpine 버전은 버그가 많았음.
FILE_NAME_ONLY=`basename "$1" .pdf`
OPTIMIZED_NAME="${FILE_NAME_ONLY}.opt.pdf"

docker run --rm -i --user "$(id -u):$(id -g)" --workdir /data -v "$PWD:/data" jbarlow83/ocrmypdf-ubuntu --tesseract-timeout=0 --optimize 3 --skip-text "/data/$1" "/data/$OPTIMIZED_NAME"
