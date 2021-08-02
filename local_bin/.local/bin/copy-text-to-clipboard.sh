#!/bin/sh
# 가끔 한글 입력이 안되는 애플리케이션에서 단축키로 호출하여 한글을 입력하면, 그 결과를 클립보드로 복사해준다.
# 마지막 새줄을 제거하기 위해 sed 사용 - https://stackoverflow.com/a/58129173/1051402
# zenity --entry --title "텍스트 복사기" --text "클립보드로 복사할 텍스트 입력: " | sed -z '$ s/\n$//' | xclip -i -sel clip
kdialog --title "텍스트 복사기"  --textinputbox "복사할 메시지는?" | sed -z '$ s/\n$//' | xclip -i -sel clip

