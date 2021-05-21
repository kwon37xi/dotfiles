#!/bin/bash
function change_app_show_banners() {
    APPS=( $(dconf list "/org/gnome/desktop/notifications/application/") )
    declare -p APPS

    local enable=$1

    for app in "${APPS[@]}"
    do
        echo "$app 'enable' to -> $enable"
        dconf write "/org/gnome/desktop/notifications/application/${app}enable" $enable
        # show-banners has no effect
        # dconf write "/org/gnome/desktop/notifications/application/${app}show-banners" $enable
    done

}

# first sync current state
change_app_show_banners $(gsettings get org.gnome.desktop.notifications show-banners)

# monitoring show-banners value
while read line
do
    show_banners=$(echo $line | cut -d' ' -f2)
    echo "current gnome notifications show-banners : $show_banners"
    change_app_show_banners $show_banners
done < <(gsettings monitor org.gnome.desktop.notifications show-banners)
