# cd up

alias up="cd .."
alias up1="cd .."
alias up2="cd ../.."
alias up3="cd ../../.."
alias up4="cd ../../../.."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias bd=". bd -si"

# bash-it custom aliases
alias ydl="youtube-dl -o '%(title).36s-%(id)s.%(ext)s"
alias ydlmp3="youtube-dl -o '%(title).36s-%(id)s.%(ext)s' --extract-audio --audio-format mp3"

# 한국 Windows 에서 압축된 zip 파일 풀기
alias kunzip="unzip -O cp949"

# ubuntu fdfind 패키지는 fd 를 fdfind 로 변경해둔 상태임
alias fd=fdfind
alias fblog-logstash='fblog -m message -l level -t timestamp --main-line-format "{{fblog_timestamp}} {{level_style fblog_level}} [{{thread}}] ({{caller_file_name}}#{{caller_method_name}}) {{fblog_message}}"'
# ubuntu bat package는 bat 을 batcat 명령으로 변경해 둔상태임
alias bat=batcat
# copy from/to clipboard for cli
alias xccopy='xclip -i -sel clip'
alias xcpaste='xclip -o -sel clip'

# stow
alias restow='stow -d ~/.dotfiles -t ~/ -R'
alias unstow='stow -d ~/.dotfiles -t ~/ -D'

# apt update/upgrade
alias sysup='sudo apt update && sudo apt -y upgrade && sudo apt  -y autoremove && sudo apt clean && flatpak update -y && sudo snap refresh && brew update && brew upgrade && brew autoremove && brew cleanup --prune=all && sdk update && sdk upgrade'
# apt search names only
alias aptsearch='apt search --names-only'

# exa as ls
alias ls='exa -lgah --colour=always --icons --git --group-directories-first'
alias ll='exa -lgah --colour=always --icons --git --group-directories-first'
alias lt='exa -lah --colour=always --icons --git --group-directories-first --tree'
alias l='exa'
alias l1='exa -1 --group-directories-first --icons'

# 전체 경로 포함해서 출력. 파일과 링크
alias lsfp='find $PWD -maxdepth 1 -type f,l'
# 전체 경로 포함해서 출력 - 서브디렉토리까지
alias lsfpall='find $PWD -type f,l'

# upgrade dotfiles
alias dotup="cd $HOME/.dotfiles;git pull;restow bashrc.d;restow local_bin;cd -"

# terraform
alias tf=terraform

# df -> duf
alias df="duf -hide loops"

# 오직 현재 파티션에 속하는 디렉토리에 대한 사용량 검사
alias dux="du --human-readable --max-depth=1 --one-file-system"
alias ncdu="ncdu -x --color dark"

# flameshot
alias flameshot="flatpak run org.flameshot.Flameshot"

# node.js yarn
alias yarn="yarnpkg"

# tldr
alias tldr="tldr --theme=ocean"

# editor
alias se=sudoedit
alias nn=nano

# nvidia, intel graphic
alias nvidiastats="nvidia-smi -q -g 0 -d UTILIZATION -l 1"
alias intelstats="sudo intel_gpu_top"

# start
alias start=xdg-open
alias xo=xdg-open
