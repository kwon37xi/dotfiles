#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob

# 최소 필요사항 설치
set +x
echo -n "Password for sudo: "
read -s SUDO_PASSWORD
echo "설치를 시작합니다."
#echo "$SUDO_PASSWORD" | sudo --stdin --prompt='' add-apt-repository -y ppa:ansible/ansible # ansible ubuntu 기본 버전의 버그가 간혹 있어서 PPA로 설치
echo "$SUDO_PASSWORD" | sudo --stdin --prompt='' apt-get -y install git ansible xz-utils unzip
set -x

ansible-galaxy collection install community.general

git clone https://kwon37xi@github.com/kwon37xi/dotfiles.git ~/.dotfiles

export ANSIBLE_LOG_PATH=~/ansible-dotfiles.log
ansible-playbook -vvv ~/.dotfiles/_installer/main_playbook.yml --extra-vars="ansible_become_pass='{{ lookup('env', 'SUDO_PASSWORD') }}'"

echo "      installation finished. REBOOT! "
