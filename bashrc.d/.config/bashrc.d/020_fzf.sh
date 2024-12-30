# Setup fzf
# ---------
#if [[ ! "$PATH" == */home/linuxbrew/.linuxbrew/opt/fzf/bin* ]]; then
  #export PATH="${PATH:+${PATH}:}/home/linuxbrew/.linuxbrew/opt/fzf/bin"
#fi

eval "$(fzf --bash)"

# Auto-completion
# ---------------
#[[ $- == *i* ]] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
#source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.bash"

# 모든 환경변수 설정은 ~/.config/environment.d/999-fzf-env.conf 로 넘김
