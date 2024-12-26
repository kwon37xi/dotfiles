#!/usr/bin/env bash
wifi_interface=$(iw dev | awk '$1=="Interface"{print $2}')
if [ -z "$wifi_interface" ]; then
        zenity --warning --text="Wi-Fi 인터페이스를 찾을 수 없습니다."
        exit 1
fi

ipv4_address=$(ip -4 addr show dev $wifi_interface | grep inet | awk '{print $2}' | cut -d/ -f1)
if [ -z "$ipv4_address" ]; then
        zenity --warning --text="IPv4 주소를 찾을 수 없습니다."
    else
        zenity --entry --text="Wi-Fi 인터페이스 ($wifi_interface)의 IPv4 주소" --entry-text="$ipv4_address"
fi
