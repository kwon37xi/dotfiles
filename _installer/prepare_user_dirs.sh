# change default directory names to english (Downloads, Desktop, ...)
echo "### 사용자 디렉토리 변경 ###"
xdg-user-dirs-update --set DESKTOP $HOME/Desktop
if [ -d ~/바탕화면 ]; then
    mv ~/바탕화면 ~/Desktop
fi

xdg-user-dirs-update --set DOWNLOAD $HOME/Downloads
if [ -d ~/다운로드 ]; then
    mv ~/다운로드 ~/Downloads
fi

xdg-user-dirs-update --set TEMPLATES $HOME/Templates
if [ -d ~/템플릿 ]; then
    mv ~/템플릿 ~/Templates
fi

xdg-user-dirs-update --set PUBLICSHARE $HOME/Public
if [ -d ~/공개 ]; then
    mv ~/공개 ~/Public
fi

xdg-user-dirs-update --set DOCUMENTS $HOME/Documents
if [ -d ~/문서 ]; then
    mv ~/문서 ~/Documents
fi

xdg-user-dirs-update --set MUSIC $HOME/Music
if [ -d ~/음악 ]; then
    mv ~/음악 ~/Music
fi

xdg-user-dirs-update --set PICTURES $HOME/Pictures
if [ -d ~/사진 ]; then
    mv ~/사진 ~/Pictures
fi

xdg-user-dirs-update --set VIDEOS $HOME/Videos
if [ -d ~/비디오 ]; then
    mv ~/비디오 ~/Videos
fi

