#!/bin/bash
status="$(wmctrl -m | grep "showing the desktop" | sed -r 's/(.*)(ON|OFF)/\2/g')"

if [ $status == "ON" ]; then
    wmctrl -k off
else
    wmctrl -k on
fi
