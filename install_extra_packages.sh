#!/bin/bash
# 초기 설정 부담이 커서, 당장 필요하지는 않은 보조 애플리케이션들 설치
set -eux -o pipefail
shopt -s failglob

if command -v sudo.ws >/dev/null 2>&1; then
    export ANSIBLE_BECOME_EXE='sudo.ws'
fi

export ANSIBLE_LOG_PATH=~/ansible-dotfiles.log
ansible-playbook -vv ~/.dotfiles/_installer/extra_package_install_playbook.yml
