#!/bin/bash
adb shell ime set "com.egloos.woongyee.sesak/.SesakKeyboardService"
/home/linuxbrew/.linuxbrew/bin/scrcpy --otg --window-height=768 --window-width=432
adb shell ime set "com.samsung.android.honeyboard/.service.HoneyBoardService"
