#!/bin/sh
# 가끔 한글 입력이 안되는 애플리케이션에서 단축키로 호출하여 한글을 입력하면, 그 결과를 클립보드로 복사해준다.
zenity --entry --title "텍스트 복사기" --text "클립보드로 복사할 텍스트 입력: " | xclip -i -sel clip
