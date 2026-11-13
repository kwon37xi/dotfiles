#!/bin/env bash
# Thinkpad 블루투스 연결 오동작 때문에 마우스 자체를 아예 삭제하고 다시 맺는 식으로 한다.
DEVICE_ID="98:FD:B4:7A:E3:52"

# 기존에 남아있는 꼬인 페어링 정보 초기화 (에러 메시지는 숨김 처리)
bluetoothctl remove $DEVICE_ID

read -p "마우스를 페어링 모드로 전환한 후 [Enter] 키를 누르세요..."

echo "1. 블루투스 전원 활성화 및 주변 기기 검색 중 (6초 소요)..."
bluetoothctl power on
bluetoothctl --timeout 6 scan on

echo "2. 마우스 페어링 시도 중..."
bluetoothctl pair $DEVICE_ID
sleep 2

echo "3. 신뢰할 수 있는 장치로 등록 중..."
bluetoothctl trust $DEVICE_ID
sleep 1

echo "4. 마우스 연결 시도 중..."
bluetoothctl connect $DEVICE_ID

echo "작업이 완료되었습니다."
