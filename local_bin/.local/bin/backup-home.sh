#!/bin/sh

# $HOME 의 주요 데이터를 tar.gz로 백업한다.
rm -rf ~/.local/backup

# NetworkManager WiFi, VPN 접속정보들 백업
mkdir -p ~/.local/backup/etc/NetworkManager
sudo cp -R /etc/NetworkManager/system-connections ~/.local/backup/etc/NetworkManager
sudo chown -R $USER:$USER ~/.local/backup

# "Service Worker"는 vivald의 캐시 디렉토리로, 백업 불필요.
tar cvpzf /tmp/home-backups.tar.gz --one-file-system --exclude="Service Worker" -C ~ \
    .config/JetBrains \
    .local/share/JetBrains \
    .config/vivaldi/Default \
    .config/asbru \
    .local/share/keyrings \
    .local/share/kwalletd \
    .local/share/DBeaverData \
    .PlayOnLinux \
    .local/backup
