#!/bin/bash

CMD="$2"
NUM_WORKSPACES=$1
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
