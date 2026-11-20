#!/bin/bash

sketchybar --add item front_app left \
  --set front_app \
    icon.drawing=off \
    label.font="$FONT:Bold:11.0" \
    label.color=$WHITE \
    background.color=0x40585b70 \
    background.corner_radius=4 \
    background.height=18 \
    background.padding_left=6 \
    background.padding_right=6 \
    script="$HOME/.config/sketchybar/plugins/front_app.sh" \
  --subscribe front_app front_app_switched
