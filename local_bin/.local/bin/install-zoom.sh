#!/bin/sh
# flatpak 버전이 안정화 되어서 flatpak 버전으로 설치
# zoom.us 를 자동으로 다운로드 하고 설치한다.
# zoom.us 가 debian/ubuntu package repository 를 제공해주지 않아서 이런 처리 필요하다.

rm -f /tmp/zoom_amd64.deb
wget -O /tmp/zoom_amd64.deb https://zoom.us/client/latest/zoom_amd64.deb

sudo apt install /tmp/zoom_amd64.deb

rm -f /tmp/zoom_amd64.deb
