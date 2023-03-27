#!/usr/bin/env bash
# Gnome Dock App Grid icon change
mkdir -p ~/.icons/Yaru/scalable/actions
mkdir -p ~/.icons/Yaru/symbolic/actions

rm ~/.icons/Yaru/scalable/actions/view-app-grid-symbolic.png
rm ~/.icons/Yaru/symbolic/actions/view-app-grid-symbolic.png

cp $1 ~/.icons/Yaru/scalable/actions/view-app-grid-symbolic.png
cp $1 ~/.icons/Yaru/symbolic/actions/view-app-grid-symbolic.png

