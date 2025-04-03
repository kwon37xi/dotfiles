#!/usr/bin/env bash
# scrcpy 를 이용해 특정 앱을 PC 화면에 별도 실행한다.
/home/linuxbrew/.linuxbrew/bin/scrcpy --new-display=1920x1080/240 --start-app="$1"
