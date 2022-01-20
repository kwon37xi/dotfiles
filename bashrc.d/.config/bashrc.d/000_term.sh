# https://github.com/vim-airline/vim-airline/issues/829
# vim-airline 플러그인이 제대로 안나오는 현상 해결
export TERM=screen-256color

export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
# history 명령에 날짜 출력
export HISTTIMEFORMAT="%Y-%m-%d %T "

export VISUAL=nano
export EDITOR=$VISUAL
export SUDO_EDITOR=$VISUAL

export CDPATH=$HOME:$HOME/projects/personal:$HOME/projects/woowabros

# https://apple.stackexchange.com/questions/88515/how-do-i-edit-current-shell-command-in-vi
# Ctrl+X Ctrl+E 를 누르면 현재 명령을 vi 에디터에서 편집할 수 있다.
bind -m vi-insert '"\C-x\C-e": edit-and-execute-command'

# ~/.inputrc 에 vi 모드가 있으면, shell-expand-line 이 자동 지정이 안된다. 강제 지정필요.
# https://unix.stackexchange.com/questions/624388/expand-shell-variable-while-editing-command-line
# meta(alt)+ctrl+l : shell($VAR) expand
bind '"\e\C-l": shell-expand-line'

# meta(alt)-ctrl-a : alias expand
bind '"\e\C-a": alias-expand-line'
