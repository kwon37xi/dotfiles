#!/bin/sh
xclip -o -sel clip | sed -Ez '$ s/\n+$//' \
| sed 's/$/,/' \
| sed '$ s/,$//' \
| xclip -i -sel clip
