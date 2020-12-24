alias youtube-dl="python3 /usr/local/bin/youtube-dl"
alias ydl="python3 /usr/local/bin/youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"
alias kunzip="unzip -O cp949"
alias fd=fdfind
alias fblog-logstash='fblog -m message -l level -t timestamp --main-line-format "{{fblog_timestamp}} {{level_style fblog_level}} [{{thread}}] ({{caller_file_name}}#{{caller_method_name}}) {{fblog_message}}"'

# copy from/to clipboard for cli
alias xccopy='xclip -i -sel clip'
alias xcpaste='xclip -o -sel clip'

# stow
alias restow='stow -d ~/.dotfiles -t ~/ -R'

# batcat -> bat
alias bat='batcat'

# mkdir & cd https://unix.stackexchange.com/questions/125385/combined-mkdir-and-cd
mkcd()
{
  mkdir -p -- "$1"
  cd -P -- "$1"
}
