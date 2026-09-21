#!/bin/sh
# flatpak 버전이 안정화 되어서 flatpak 버전으로 설치
# zoom.us 를 자동으로 다운로드 하고 설치한다.
# zoom.us 가 debian/ubuntu package repository 를 제공해주지 않아서 이런 처리 필요하다.
# 이미 최신 버전이 설치돼 있으면 다운로드/설치하지 않고 종료한다.

LATEST_URL="https://zoom.us/client/latest/zoom_amd64.deb"

# https://zoom.us/client/latest/zoom_amd64.deb 는
# https://cdn.zoom.us/prod/<version>/zoom_amd64.deb 로 redirect 되므로
# 최종 URL 에서 최신 버전을 알아낸다.
DOWNLOAD_URL=$(curl -sIL -o /dev/null -w '%{url_effective}' "$LATEST_URL")
LATEST_VERSION=$(echo "$DOWNLOAD_URL" | sed -n 's|.*/prod/\([0-9][0-9.]*\)/.*|\1|p')
INSTALLED_VERSION=$(dpkg-query -W -f='${Version}' zoom 2>/dev/null)

echo "installed version: ${INSTALLED_VERSION:-(none)}"
echo "latest version   : ${LATEST_VERSION:-(unknown)}"

if [ -n "$LATEST_VERSION" ] && [ "$LATEST_VERSION" = "$INSTALLED_VERSION" ]; then
    echo "zoom $INSTALLED_VERSION 이 이미 설치되어 있습니다. 설치를 건너뜁니다."
    exit 0
fi

# 최신 버전을 알아내지 못했다면 원래 URL 로 그냥 다운로드 한다.
[ -n "$LATEST_VERSION" ] || DOWNLOAD_URL="$LATEST_URL"

rm -f /tmp/zoom_amd64.deb
wget -O /tmp/zoom_amd64.deb "$DOWNLOAD_URL"

sudo apt install /tmp/zoom_amd64.deb

rm -f /tmp/zoom_amd64.deb
