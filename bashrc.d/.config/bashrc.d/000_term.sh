# https://github.com/vim-airline/vim-airline/issues/829
# vim-airline 플러그인이 제대로 안나오는 현상 해결
export TERM=screen-256color

export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
# history 명령에 날짜 출력
export HISTTIMEFORMAT="%Y-%m-%d %T "

export VISUAL=vim
export EDITOR=$VISUAL
export SUDO_EDITOR=$VISUAL

#CDPATH가 있으면 더 불편한 듯.
#export CDPATH=.:$HOME:$HOME/projects/personal:$HOME/projects/woowabros

# https://apple.stackexchange.com/questions/88515/how-do-i-edit-current-shell-command-in-vi
# Ctrl+X Ctrl+E 를 누르면 현재 명령을 vi 에디터에서 편집할 수 있다.
bind -m vi-insert '"\C-x\C-e": edit-and-execute-command'

# ~/.inputrc 에 vi 모드가 있으면, shell-expand-line 이 자동 지정이 안된다. 강제 지정필요.
# https://unix.stackexchange.com/questions/624388/expand-shell-variable-while-editing-command-line
# meta(alt)+ctrl+l : shell($VAR) expand 환경 변수를 실제값으로 바꿔준다.
bind '"\e\C-l": shell-expand-line'

# meta(alt)-ctrl-a : alias expand
bind '"\e\C-a": alias-expand-line'

# 각종 키 바인딩 https://www.youtube.com/watch?v=iKzoYUErEM0
# archwiki readline  https://wiki.archlinux.org/title/readline
# history : 몇글자 치고 위화살표/아래화살표 누르면 글자가 앞부분이 매칭되는 히스토리만 나옴
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Alt+Ctrl-k : 부모 디렉토리로, 처음에는 \n 으로 엔터를 했으나 작동 안해서 \C-m 으로 변경함.
bind '"\e\C-k": "cd ..\C-m"'
# meta(alt)-s : 현재 명령에 sudo 붙여주기 - vi mode. \C-[ 는 ESC 키를 의미함.
bind '"\es": "\C-[Isudo \C-[$a"'
# emacs mode : "\C-asudo \C-e"

# https://brettterpstra.com/2015/07/09/shell-tricks-inputrc-binding-fun/
# Alt-z : cd - 로 직전 디렉토리로 이동하기
bind '"\ez": "cd -\n"'
