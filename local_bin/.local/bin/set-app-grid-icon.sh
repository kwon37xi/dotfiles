#!/usr/bin/env bash
# Gnome Dock App Grid icon change
mkdir -p ~/.icons/Yaru/scalable/actions
mkdir -p ~/.icons/Yaru/symbolic/actions

rm ~/.icons/Yaru/scalable/actions/view-app-grid-symbolic.png
rm ~/.icons/Yaru/symbolic/actions/view-app-grid-symbolic.png

TARGET_ICON="$1"

if [ -z "${TARGET_ICON}" ]; then
    TARGET_ICON=~/.dotfiles/_icons/ubuntu/cof_orange_hex.png
fi
cp "${TARGET_ICON}" ~/.icons/Yaru/scalable/actions/view-app-grid-symbolic.png
cp "${TARGET_ICON}" ~/.icons/Yaru/symbolic/actions/view-app-grid-symbolic.png

