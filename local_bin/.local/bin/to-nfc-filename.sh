#!/bin/sh
# Mac OS 에서 NFD 인코딩 파일명을 Linux/Win 용 NFC로 변환한다.
convmv -f utf-8 -t utf-8 --nfc --notest "$1"
