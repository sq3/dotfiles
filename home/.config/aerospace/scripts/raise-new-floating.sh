#!/bin/sh
# Focus a newly opened window if it ended up floating (otherwise it can open behind tiled windows)

sleep 0.2
newest=$(aerospace list-windows --monitor all --format '%{window-id}|%{window-layout}' | sort -t'|' -k1,1n | tail -1)
id=${newest%%|*}
[ "${newest#*|}" = floating ] || exit 0
aerospace focus --window-id "$id"
