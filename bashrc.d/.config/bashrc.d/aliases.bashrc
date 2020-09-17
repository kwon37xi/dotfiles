alias ydl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"
alias kunzip="unzip -O cp949"
alias fd=fdfind
alias fblog-logstash='fblog -m message -l level -t timestamp --main-line-format "{{fblog_timestamp}} {{level_style fblog_level}} [{{thread}}] ({{caller_file_name}}#{{caller_method_name}}) {{fblog_message}}"'
