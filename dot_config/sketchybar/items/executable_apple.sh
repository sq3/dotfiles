#!/bin/bash

sketchybar --add item apple left \
  --set apple \
    icon= \
    icon.font="$ICON_FONT:Bold:14.0" \
    icon.color=$WHITE \
    background.color=$ACCENT_COLOR \
    background.corner_radius=6 \
    background.height=22 \
    padding_left=6 \
    padding_right=6 \
    label.drawing=off \
    click_script="open -a 'System Preferences'"
