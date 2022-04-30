fzf-down() {
  fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

# from https://github.com/junegunn/dotfiles/blob/master/bashrc / https://junegunn.kr/2016/07/fzf-git/
# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# git 변경된 파일 목록 선택
_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
  cut -c4- | sed 's/.* -> //'
}

# git 브랜치 목록 선택
_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

# git tag 선택
_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

# git commit history 에서 commit hash 선택
_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

# git remote 선택
_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
  cut -d$'\t' -f1
}

# git statsh 선택
_gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

# Extra
# process 목록
_gp() {
  ps -ef | fzf-down --header-lines 1 --info inline --layout reverse --multi |
    awk '{print $2}'
}

# $- =~ i 는 interactive shell 일 경우에 true
if [[ $- =~ i ]]; then
  # tmux 가 아닌경우 redraw-current-line 이 필요할 수있음.
  bind '"\er": redraw-current-line'
  # shell-expand-line 은 bind-x*.bashrc에서 \e\C-l 로 지정했음.
  bind '"\C-g\C-f": "$(_gf)\e\C-l\er"'
  bind '"\C-g\C-b": "$(_gb)\e\C-l\er"'
  bind '"\C-g\C-t": "$(_gt)\e\C-l\er"'
  bind '"\C-g\C-h": "$(_gh)\e\C-l\er"'
  bind '"\C-g\C-r": "$(_gr)\e\C-l\er"'
  bind '"\C-g\C-s": "$(_gs)\e\C-l\er"'

  # Extra
  bind '"\C-g\C-p": "$(_gp)\e\C-l\er"'
fi
