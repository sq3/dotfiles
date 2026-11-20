#!/bin/bash

# Get focused workspace from AeroSpace
FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)

# Update all space items
for i in {1..9}; do
  if [ "$FOCUSED" = "$i" ]; then
    sketchybar --set space.$i icon.highlight=on
  else
    sketchybar --set space.$i icon.highlight=off
  fi
done
