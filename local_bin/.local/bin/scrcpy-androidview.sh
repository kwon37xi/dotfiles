#!/usr/bin/env bash
# USB 접속 andview
# 세벌식으로 변경
adb shell ime set "com.egloos.woongyee.sesak/.SesakKeyboardService"
/home/linuxbrew/.linuxbrew/bin/scrcpy --select-usb --keyboard=uhid --stay-awake
# 키보드 원상 복귀
#adb shell ime set "com.lge.ime/.LgeImeImpl"
adb shell ime set "com.samsung.android.honeyboard/.service.HoneyBoardService"
