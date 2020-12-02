#!/bin/sh
# todo quit kwallet
rm -rf ~/.local/backup
rm -rf ~/.local/shareDBeaverData
rm -rf ~/.config/asbru
rm -rf ~/.local/share/kwalletd
rm -rf ~/.config/vivaldi/Default
rm -rf ~/.config/JetBrains
rm -rf ~/.local/share/JetBrains
rm -rf ~/.config/copyq
rm -rf ~/.local/share/keyrings

tar xvzf home-backups.tar.gz -C ~/

sudo cp ~/.local/backup/etc/NetworkManager/system-connections/* /etc/NetworkManager/system-connections/
sudo chown root:root /etc/NetworkManager/system-connections/
sudo chmod 0600 /etc/NetworkManager/system-connections/*
# todo restart kwallet

sudo service networking restart
