#!/bin/bash

sketchybar --add item wifi right \
  --set wifi \
    icon=󰖩 \
    icon.color=$GREEN \
    label.drawing=off \
    script="$HOME/.config/sketchybar/plugins/wifi.sh" \
    update_freq=30 \
    click_script="open 'x-apple.systempreferences:com.apple.preference.network'"
