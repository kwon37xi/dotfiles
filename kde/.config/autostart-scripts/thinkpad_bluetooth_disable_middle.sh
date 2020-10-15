#!/bin/sh
# disable thinkpad bluetooth mouse middle button web browser prev/next action
xmodmap -e "pointer = 1 2 3 4 5 6 7 0 0 0 0 0 0" #the fix
