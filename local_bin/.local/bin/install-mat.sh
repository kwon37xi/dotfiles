#!/bin/bash
# install MAT
# 최신 버전 참조 : https://www.eclipse.org/mat/downloads.php
VERSION=1.15.0
RELEASE_DATE=20231206

echo "${VERSION}.${RELEASE_DATE}"

TARGET_URL="https://mirror.kakao.com/eclipse/mat/${VERSION}/rcp/MemoryAnalyzer-${VERSION}.${RELEASE_DATE}-linux.gtk.x86_64.zip"

echo $TARGET_URL

rm -rf /tmp/eclipse-mat.zip
wget -O /tmp/eclipse-mat.zip "${TARGET_URL}"

rm -rf ~/.local/opt/mat
mkdir -p ~/.local/opt
unzip /tmp/eclipse-mat.zip -d ~/.local/opt

# 메모리 설정 변경
sed -i.bak -e "s/Xmx1024m/Xmx8g/g" ~/.local/opt/mat/MemoryAnalyzer.ini
