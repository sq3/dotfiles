#!/bin/sh
# Pull the focused floating window onto the workspace visible under the mouse and raise it

info=$(aerospace list-windows --focused --format '%{window-id}|%{window-layout}|%{workspace}' 2>/dev/null) || exit 0
IFS='|' read -r id layout ws <<END
$info
END

[ "$layout" = floating ] || exit 0

# Our own focus call below fires on-focus-changed again; skip if we just handled this window
lock="${TMPDIR:-/tmp}/aerospace-pull-floating-$id"
now=$(date +%s)
last=$(cat "$lock" 2>/dev/null || echo 0)
[ $((now - last)) -lt 2 ] && exit 0
echo "$now" > "$lock"

target=$(aerospace list-workspaces --monitor mouse --visible)
if [ -n "$target" ] && [ "$ws" != "$target" ]; then
  aerospace move-node-to-workspace --window-id "$id" "$target"
fi

# External activation (Raycast, Cmd+Tab, open) focuses without raising; focusing via AeroSpace raises
aerospace focus --window-id "$id"
