#!/usr/bin/env bash
# scrcpy 를 이용해 특정 앱을 PC 화면에 별도 실행한다.

# 최소 2개의 파라미터가 필요
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 [wide|normal|디스플레이옵션] <app_package_name> [extra_options...]"
    exit 1
fi

# 첫 번째 파라미터에 따라 --new-display 옵션 설정
if [ "$1" == "wide" ]; then
    DISPLAY_OPTION="--new-display=1920x1080/240"
elif [ "$1" == "normal" ]; then
    DISPLAY_OPTION="--new-display"
else
    DISPLAY_OPTION="--new-display=$1"
fi

# 실행 애플리케이션 패키지 이름 뒤에 붙은 옵션을 scrcpy에 전달
# 예) wide com.egloos.woongyee.sesak/.SesakKeyboardService --no-vd-destroy-content

EXTRA_OPTIONS="${@:3}"

adb shell ime set "com.egloos.woongyee.sesak/.SesakKeyboardService"
/home/linuxbrew/.linuxbrew/bin/scrcpy $DISPLAY_OPTION \
   --no-vd-system-decorations \
   --start-app="$2" $EXTRA_OPTIONS
