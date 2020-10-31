#!/bin/sh
# thinkpad 블루투스 마우스 가운데 버튼으로 브라우저 이전/다음 이동 금지 시키기
xmodmap -e "pointer = 1 2 3 4 5 6 7 0 0 0 0 0 0"
