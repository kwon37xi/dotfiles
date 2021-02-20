# bash-it custom aliases
cite 'about-alias'
about-alias 'kwonnam''s custom aliases'


alias ydl="/usr/local/bin/youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"
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
alias aptup='sudo apt update && sudo apt upgrade && sudo apt autoremove'

# exa as ls
#alias ls=exa
alias ll='exa -lah'
alias l='exa -lah'
alias l1='exa -1'

