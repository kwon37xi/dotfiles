#!/bin/sh
# $1 는 합칠 줄 갯수. 기본값 10
JOIN_LINES=$1

if [ -z "$JOIN_LINES" ]
then
    JOIN_LINES=10
fi

xclip -o -sel clip | xargs -n $JOIN_LINES | xclip -i -sel clip
