#!/bin/bash

sketchybar --add item clock center \
  --set clock \
    icon=󰥔 \
    icon.color=$ACCENT_COLOR \
    label.font="$FONT:Bold:13.0" \
    update_freq=10 \
    script="$HOME/.config/sketchybar/plugins/clock.sh"
