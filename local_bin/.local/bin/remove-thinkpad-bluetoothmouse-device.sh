#!/bin/env bash
# 블루투스 연결 오동작 때문에 마우스 자체를 아예 삭제하고 다시 맺는 식으로 한다.
bluetoothctl devices | grep "ThinkPad Bluetooth Laser Mouse" | cut -d' ' -f2 | xargs bluetoothctl remove

