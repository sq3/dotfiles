#!/bin/bash

CPU=$(top -l 1 | grep -E "^CPU" | grep -Eo '[0-9]+\.[0-9]+%' | head -1 | cut -d'%' -f1)

if [ "$CPU" = "" ]; then
  CPU="0"
fi

sketchybar --set $NAME label="${CPU}%"
