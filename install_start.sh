#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob

# 최소 필요사항 설치
set +x
#echo "$SUDO_PASSWORD" | sudo --stdin --prompt='' add-apt-repository -y ppa:ansible/ansible # ansible ubuntu 기본 버전의 버그가 간혹 있어서 PPA로 설치
sudo apt-get -y install git ansible xz-utils unzip
set -x

# --upgrade 옵션으로 최시 번전 컬렉션을 설치하게 해야 한다.
ansible-galaxy collection install community.general --upgrade

git clone https://kwon37xi@github.com/kwon37xi/dotfiles.git ~/.dotfiles

export ANSIBLE_LOG_PATH=~/ansible-dotfiles.log
ansible-playbook -vvv ~/.dotfiles/_installer/main_playbook.yml --ask-become-pass

echo "      installation finished. REBOOT! "
