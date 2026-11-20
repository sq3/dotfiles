#!/bin/bash

sketchybar --add item battery right \
  --set battery \
    icon.font="$ICON_FONT:Bold:16.0" \
    update_freq=120 \
    script="$HOME/.config/sketchybar/plugins/battery.sh" \
  --subscribe battery system_woke power_source_change
