#!/usr/bin/env bash
# ddterm 에 대해 presentation mode 를 toggle 한다
current_font=$(dconf read '/com/github/amezin/ddterm/custom-font')
current_font="${current_font%\'}"
current_font="${current_font#\'}"
current_font_size=$(echo $current_font | awk '{print $NF}')
case $current_font_size in
    16)
        dconf write '/com/github/amezin/ddterm/custom-font' "'CodeNewRoman Nerd Font Mono 12'"
        ;;
    *)
        dconf write '/com/github/amezin/ddterm/custom-font' "'CodeNewRoman Nerd Font Mono 16'"
        ;;
esac
