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

# ubuntu 25.10 에서 sudo-rs 가 기본 sudo 명령이 되었는데, ansible이 아직 이와 호환이 안되기 때문에 구버전인 sudo.ws 로 전환
if command -v sudo.ws >/dev/null 2>&1; then
    export ANSIBLE_BECOME_EXE='sudo.ws'
fi

# --upgrade 옵션으로 최시 번전 컬렉션을 설치하게 해야 한다.
ansible-galaxy collection install community.general --upgrade

git clone https://kwon37xi@github.com/kwon37xi/dotfiles.git ~/.dotfiles

export ANSIBLE_LOG_PATH=~/ansible-dotfiles.log
ansible-playbook -vvv ~/.dotfiles/_installer/main_playbook.yml --extra-vars="ansible_become_pass='{{ lookup('env', 'SUDO_PASSWORD') }}'"

echo "      installation finished. REBOOT! "
