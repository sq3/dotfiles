#!/bin/bash

sketchybar --add item volume right \
  --set volume \
    icon.color=$MAGENTA \
    script="$HOME/.config/sketchybar/plugins/volume.sh" \
  --subscribe volume volume_change
