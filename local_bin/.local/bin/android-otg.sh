#!/bin/bash
adb shell ime set "com.egloos.woongyee.sesak/.SesakKeyboardService"
/home/linuxbrew/.linuxbrew/bin/scrcpy --otg
adb shell ime set "com.samsung.android.honeyboard/.service.HoneyBoardService"
