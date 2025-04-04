#!/usr/bin/env bash
# scrcpy 를 이용해 특정 앱을 PC 화면에 별도 실행한다.

# 첫 번째 파라미터에 따라 --new-display 옵션 설정
if [ "$1" == "wide" ]; then
    DISPLAY_OPTION="--new-display=1920x1080/240"
elif [ "$1" == "normal" ]; then
    DISPLAY_OPTION=""
else
    echo "Usage: $0 [wide|normal] <app_package_name>"
    exit 1
fi

adb shell ime set "com.egloos.woongyee.sesak/.SesakKeyboardService"
/home/linuxbrew/.linuxbrew/bin/scrcpy $DISPLAY_OPTION \
   --no-vd-system-decorations \
   --no-vd-destroy-content \
   --start-app="$2"
