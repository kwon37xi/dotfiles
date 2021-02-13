# bash-it custom aliases
cite 'about-alias'
about-alias 'kwonnam''s custom aliases'


alias ydl="/usr/local/bin/youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"
alias kunzip="unzip -O cp949"
alias fd=fdfind
alias fblog-logstash='fblog -m message -l level -t timestamp --main-line-format "{{fblog_timestamp}} {{level_style fblog_level}} [{{thread}}] ({{caller_file_name}}#{{caller_method_name}}) {{fblog_message}}"'

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

