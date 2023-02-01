#!/usr/bin/env bash
# ddterm 을 기준으로 presentation mode 를 toggle 한다
current_font=$(dconf read '/com/github/amezin/ddterm/custom-font')
current_font="${current_font%\'}"
current_font="${current_font#\'}"
current_font_size=$(echo $current_font | awk '{print $NF}')
case $current_font_size in
    14) # to normal mode
        dconf write '/com/github/amezin/ddterm/custom-font' "'SauceCodePro Nerd Font Mono 12'"
        dconf write '/com/github/amezin/ddterm/window-size' 1.0
        gsettings set org.gnome.desktop.notifications show-banners true
        notify-send -t 1000 "Presentation Mode OFF"

        ;;
    *) # to presentation mode
        notify-send -t 1000 "Presentation Mode ON"
        sleep 1
        dconf write '/com/github/amezin/ddterm/custom-font' "'SauceCodePro Nerd Font Mono 14'"
        dconf write '/com/github/amezin/ddterm/window-size' 0.6
        gsettings set org.gnome.desktop.notifications show-banners false
        ;;
esac
