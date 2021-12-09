# https://github.com/vim-airline/vim-airline/issues/829
# vim-airline 플러그인이 제대로 안나오는 현상 해결
export TERM=screen-256color

export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
# history 명령에 날짜 출력
export HISTTIMEFORMAT="%Y-%m-%d %T "

export VISUAL=nano
export EDITOR=$VISUAL
export SUDO_EDITOR=$VISUAL
