#!/usr/bin/env bash
# Gnome Dock App Grid icon change
# Ubuntu 24.04, Gnome 46 에서 view-app-grid-ubuntu-symbolic 으로 파일명 변경됨.
mkdir -p ~/.icons/Yaru/scalable/actions
#mkdir -p ~/.icons/Yaru/symbolic/actions

rm -f ~/.icons/Yaru/scalable/actions/view-app-grid-symbolic.png
rm -f ~/.icons/Yaru/scalable/actions/view-app-grid-ubuntu-symbolic.png
#rm ~/.icons/Yaru/symbolic/actions/view-app-grid-symbolic.png

TARGET_ICON="$1"

if [ -z "${TARGET_ICON}" ]; then
    TARGET_ICON=~/.dotfiles/_icons/ubuntu/cof_orange_hex.png
fi
TARGET_EXT="${TARGET_ICON##*.}"

cp "${TARGET_ICON}" "$HOME/.icons/Yaru/scalable/actions/view-app-grid-symbolic.${TARGET_EXT}"
cp "${TARGET_ICON}" "$HOME/.icons/Yaru/scalable/actions/view-app-grid-ubuntu-symbolic.${TARGET_EXT}"
#cp "${TARGET_ICON}" ~/.icons/Yaru/symbolic/actions/view-app-grid-symbolic.png

