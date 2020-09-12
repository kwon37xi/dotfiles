echo "### install custom fonts ###"
if ! [ -d ~/.fonts/free-korean-fonts ]; then
    mkdir -p ~/.fonts
    cd ~/.fonts
    git clone https://github.com/kwon37xi/free-korean-fonts.git
    fc-cache -v
fi

