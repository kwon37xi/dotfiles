#!/bin/sh
# thinkpad Bluetooth Mouse 의 가운데 빨간 버튼이 브라우저 앞으로/뒤로가기로 작동하는 것 방지
xmodmap -e "pointer = 1 2 3 4 5 6 7 0 0 0 0 0 0" #the fix
