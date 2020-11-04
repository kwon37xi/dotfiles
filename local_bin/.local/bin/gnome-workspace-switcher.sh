#!/bin/bash

# Gnome 3 based workspace changer
# only works with gnome 3 vertical workspace
# gnome-workspace-switcher.sh Up
# gnome-workspace-switcher.sh Down
#
# ref : https://www.artificialworlds.net/blog/2011/03/04/switching-workspace-in-gnome-via-the-command-line/

CMD="$1"
NUM_WORKSPACES=`gsettings get org.gnome.desktop.wm.preferences num-workspaces`
CURRENT_WS=`wmctrl -d | grep \* | cut -d " " -f 1`

MOVE_UP="-1"
MOVE_DOWN="+1"

case $CMD in

"Up" )
	WS_COL=`echo $CURRENT_WS "%" $NUM_WORKSPACES | bc`
	if [[ $WS_COL -eq 0 ]]; then
	{
		NEW_WS=$CURRENT_WS
	}
	else
	{
		NEW_WS=`echo $CURRENT_WS "- 1" | bc`
	}; fi
	;;

"Down" )
	NEW_WS=`echo $CURRENT_WS "+ 1" | bc`
	NEW_WS_COL=`echo $NEW_WS "%" $NUM_WORKSPACES | bc`
	if [[ $NEW_WS_COL -eq 0 ]]; then NEW_WS=$CURRENT_WS; fi
	;;

* )
	NEW_WS=$CMD

esac

wmctrl -s $NEW_WS
