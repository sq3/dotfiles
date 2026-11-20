#!/bin/bash

WIFI=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)
SSID=$(echo "$WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME icon=󰖪 icon.color=0xfff38ba8
else
  sketchybar --set $NAME icon=󰖩 icon.color=0xffa6e3a1
fi
