#!/bin/bash
# error 발생시 즉각 중단.
set -eux -o pipefail
shopt -s failglob

if [ $# -ne 1 ]; then
	echo "Usage install_start-at-task.sh <task-name>"
	exit 1
else
	echo "Start installing at '$1' ..."
fi
# 최소 필요사항 설치
set +x

# ubuntu 25.10 에서 sudo-rs 가 기본 sudo 명령이 되었는데, ansible이 아직 이와 호환이 안되기 때문에 구버전인 sudo.ws 로 전환
if command -v sudo.ws >/dev/null 2>&1; then
    export ANSIBLE_BECOME_EXE='sudo.ws'
fi

export ANSIBLE_LOG_PATH=~/ansible-dotfiles-step-at.log
ansible-playbook -vvv ~/.dotfiles/_installer/main_playbook.yml --start-at-task="$1" --step --ask-become-pass
