#!/bin/bash
function change_app_notification() {
    APPS=( $(dconf list "/org/gnome/desktop/notifications/application/") )
    declare -p APPS

    local enable=$1

    for app in "${APPS[@]}"
    do
        logger --tag="gnome-dnd-monitor" "$app 'enable' to -> $enable"
        dconf write "/org/gnome/desktop/notifications/application/${app}enable" $enable
        # show-banners has no effect
        # dconf write "/org/gnome/desktop/notifications/application/${app}show-banners" $enable
    done

}

# first sync current state
change_app_notification $(gsettings get org.gnome.desktop.notifications show-banners)

# monitoring show-banners value
while read line
do
    show_banners=$(echo $line | cut -d' ' -f2)
    logger --tag="gnome-dnd-monitor" "current gnome notifications show-banners : $show_banners"
    change_app_notification $show_banners
done < <(gsettings monitor org.gnome.desktop.notifications show-banners)
