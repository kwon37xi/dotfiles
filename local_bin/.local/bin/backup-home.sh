#!/bin/sh

# $HOME 의 주요 데이터를 tar.gz로 백업한다.
rm -rf ~/.local/backup

# NetworkManager WiFi, VPN 접속정보들 백업
~/.dotfiles/local_bin/.local/bin/backup-networkmanager.sh

mkdir -p ~/.config/JetBrains
mkdir -p ~/.local/share/JetBrains
mkdir -p ~/.local/share/keyrings
mkdir -p ~/.local/share/DBeaverData
mkdir -p ~/.local/backup

# "Service Worker"는 vivald의 캐시 디렉토리로, 백업 불필요.
tar cvpzf /tmp/home-backups.tar.gz --one-file-system --exclude="Service Worker" -C ~ \
    .config/JetBrains \
    .local/share/JetBrains \
    .local/share/keyrings \
    .local/share/DBeaverData \
    .local/backup

# 더이상 안 사용하는 부분들
#    .config/vivaldi/Default \
#    .config/asbru \
#    .local/share/kwalletd \
#    .PlayOnLinux \

echo "/tmp/home-backups.tar.gz 로 모든 백업이 완료됨"
