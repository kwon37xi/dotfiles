#!/bin/sh
if $(gsettings get org.gnome.desktop.notifications show-banners); then
    notify-send -t 2000 "GNOME notification show-banners -> false"
    gsettings set org.gnome.desktop.notifications show-banners false
else
    gsettings set org.gnome.desktop.notifications show-banners true
    notify-send -t 2000 "GNOME notification show-banners -> true"
fi
