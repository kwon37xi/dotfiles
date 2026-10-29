#!/usr/bin/env bash
# pdf-opt.sh 원본.pdf
# 결과는 원본.opt.pdf
# alpine 버전은 버그가 많았음.
FILE_NAME_ONLY=`basename "$1" .pdf`
OPTIMIZED_NAME="${FILE_NAME_ONLY}.opt.pdf"

# docker를 rootless로 실행하기 때문에 이제는 docker 내부 사용자를 0:0(root)로 지정해도 실제로는 host의 일반 사용자로 매핑된다.
docker run --rm -i --user "0:0" --workdir /data -v "$PWD:/data" jbarlow83/ocrmypdf-ubuntu --tesseract-timeout=0 --optimize 3 --skip-text "/data/$1" "/data/$OPTIMIZED_NAME"
