#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob

# 최소 필요사항 설치
set +x
echo -n "Password for sudo: "
read -s SUDO_PASSWORD
echo "$SUDO_PASSWORD" | sudo -S apt-get -y install git ansible xz-utils unzip
set -x

ansible-galaxy collection install community.general

git clone https://kwon37xi@github.com/kwon37xi/dotfiles.git ~/.dotfiles

ANSIBLE_CONFIG=~/.dotfiles/_installer/ansible.cfg \
    ansible-playbook -vv ~/.dotfiles/_installer/main_playbook.yml \
    --extra-vars="ansible_become_pass='{{ lookup('env', 'SUDO_PASSWORD') }}'"

echo "      installation finished. REBOOT! "
