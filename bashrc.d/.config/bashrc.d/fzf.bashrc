# Setup fzf
# ---------
#if [[ ! "$PATH" == */home/linuxbrew/.linuxbrew/opt/fzf/bin* ]]; then
  #export PATH="${PATH:+${PATH}:}/home/linuxbrew/.linuxbrew/opt/fzf/bin"
#fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/share/fzf/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/share/fzf/key-bindings.bash"


# FZF OPTS from https://www.youtube.com/watch?v=tB-AgxzBmH8
export FZF_DEFAULT_COMMAND='fdfind --follow --hidden --exclude .git --exclude "*.class" --color=always'
export FZF_DEFAULT_OPTS='--no-height --ansi --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b --bind alt-j:down,alt-k:up'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type f"
export FZF_CTRL_T_OPTS="--preview 'batcat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

export FZF_TMUX=1
# todo TMUX options..
