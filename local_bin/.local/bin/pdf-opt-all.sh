
#!/usr/bin/env bash
# 현재 디렉토리의 모든 PDF 파일을 최적화 한다. 단 .opt.pdf 는 제외한다.

for f in *.pdf; do

    if [[ $f != *".opt.pdf" ]]; then
        echo "> current processing file - $f"
        pdf-opt.sh "$f"
    fi

done
