# https://apple.stackexchange.com/questions/88515/how-do-i-edit-current-shell-command-in-vi
# Ctrl+X Ctrl+E 를 누르면 현재 명령을 vi 에디터에서 편집할 수 있다.
bind -m vi-insert '"\C-x\C-e": edit-and-execute-command'
