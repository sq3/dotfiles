#!/bin/bash

# Create space items for workspaces 1-9
for i in {1..9}; do
  sketchybar --add item space.$i left \
    --set space.$i \
      associated_space=$i \
      icon=$i \
      icon.font="$FONT:Bold:15.0" \
      icon.color=$GREY \
      icon.highlight_color=$WHITE \
      label.drawing=off \
      padding_left=2 \
      padding_right=2 \
      script="$HOME/.config/sketchybar/plugins/space.sh" \
      click_script="aerospace workspace $i" \
    --subscribe space.$i aerospace_workspace_change
done

# Separator after spaces
sketchybar --add item space_separator left \
  --set space_separator \
    icon="│" \
    icon.color=$GREY \
    icon.padding_left=6 \
    icon.padding_right=6 \
    label.drawing=off \
    background.drawing=off
