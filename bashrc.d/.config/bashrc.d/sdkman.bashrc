#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/${USER}/.sdkman"
[[ -s "/home/${USER}/.sdkman/bin/sdkman-init.sh" ]] && source "/home/${USER}/.sdkman/bin/sdkman-init.sh"

# sdkman completion bash 명령이 시간이 오래 걸리기 때문에 파일을 생성해두고 반복 적재하는 방식
if [ ! -f "${HOME}/.config/bashrc.d/sdkman.completion" ]; then
    (sdk completion bash) > $HOME/.config/bashrc.d/sdkman.completion
fi

source $HOME/.config/bashrc.d/sdkman.completion
