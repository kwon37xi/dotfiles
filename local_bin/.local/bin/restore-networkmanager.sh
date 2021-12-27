#!/usr/bin/env bash
# local 에 백업한 NetworkManager connection 정보를 다시 복원한다.

logger "networkmanager connections restoring started."
sudo cp ~/.local/backup/networkmanager/etc/NetworkManager/system-connections/* /etc/NetworkManager/system-connections/
sudo chown root:root /etc/NetworkManager/system-connections/
sudo chmod 0600 /etc/NetworkManager/system-connections/*

sudo systemctl restart NetworkManager.service

logger "networkmanager connections restored successfully"
