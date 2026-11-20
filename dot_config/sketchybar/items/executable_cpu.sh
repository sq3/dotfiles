#!/bin/bash

sketchybar --add item cpu right \
  --set cpu \
    icon=󰻠 \
    icon.color=$ORANGE \
    update_freq=5 \
    script="$HOME/.config/sketchybar/plugins/cpu.sh"
