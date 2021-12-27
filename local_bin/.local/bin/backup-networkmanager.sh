#!/usr/bin/env bash
# NetworkManager의 설정 정보들을 local 로 백업한다.
# 이 백업된 정보들은 다시 pika/dejadup 등을 통해 원격지로 백업된다.

logger "networkmanager connections backup started"
rm -rf ~/.local/backup/networkmanager
mkdir -p ~/.local/backup/networkmanager/etc/NetworkManager
sudo cp -R /etc/NetworkManager/system-connections ~/.local/backup/networkmanager/etc/NetworkManager
sudo chown -R $USER:$USER ~/.local/backup/networkmanager

logger "networkmanager connections backuped successfully"
