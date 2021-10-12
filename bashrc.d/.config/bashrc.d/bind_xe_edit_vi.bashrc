# https://apple.stackexchange.com/questions/88515/how-do-i-edit-current-shell-command-in-vi
# Ctrl+X Ctrl+E 를 누르면 현재 명령을 vi 에디터에서 편집할 수 있다.
bind -m vi-insert '"\C-x\C-e": edit-and-execute-command'

# ~/.inputrc 에 vi 모드가 있으면, shell-expand-line 이 자동 지정이 안된다. 강제 지정필요.
# https://unix.stackexchange.com/questions/624388/expand-shell-variable-while-editing-command-line
# meta(alt)+ctrl+l : shell($VAR) expand
bind '"\e\C-l": shell-expand-line'

# meta(alt)-ctrl-a : alias expand
bind '"\e\C-a": alias-expand-line'

