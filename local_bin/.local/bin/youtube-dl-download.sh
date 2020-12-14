#!/bin/sh
# youtube-dl 최신버전을 지속적으로 다운로드 하기
# youtube-dl 은 youtube에서 지속적으로 다운로드 방어를 하기 때문에 최신 버전으로 계속 업그레이드가 필요하다.
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod 755 /usr/local/bin/youtube-dl

