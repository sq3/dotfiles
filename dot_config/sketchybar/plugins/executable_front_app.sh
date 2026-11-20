#!/usr/bin/env bash

ICON_PADDING_RIGHT=5

case "$INFO" in
"Arc")
    ICON_PADDING_RIGHT=5
    ICON=󰞍
    ;;
"Code" | "Visual Studio Code")
    ICON_PADDING_RIGHT=4
    ICON=󰨞
    ;;
"Calendar")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Discord")
    ICON=
    ;;
"FaceTime")
    ICON_PADDING_RIGHT=5
    ICON=
    ;;
"Finder")
    ICON=󰀶
    ;;
"Google Chrome")
    ICON_PADDING_RIGHT=7
    ICON=
    ;;
"Safari")
    ICON_PADDING_RIGHT=5
    ICON=󰀹
    ;;
"IINA")
    ICON_PADDING_RIGHT=4
    ICON=󰕼
    ;;
"kitty" | "Terminal" | "iTerm2" | "Alacritty" | "WezTerm")
    ICON=󰄛
    ;;
"Messages")
    ICON=
    ;;
"Notion")
    ICON_PADDING_RIGHT=6
    ICON=󰎚
    ;;
"Preview")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Spotify")
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
"Slack")
    ICON_PADDING_RIGHT=4
    ICON=󰒱
    ;;
"Telegram")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
"WhatsApp")
    ICON_PADDING_RIGHT=4
    ICON=󰖣
    ;;
"Mail")
    ICON_PADDING_RIGHT=4
    ICON=󰇮
    ;;
"Notes")
    ICON_PADDING_RIGHT=4
    ICON=󰎞
    ;;
"System Preferences" | "System Settings")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
*)
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
esac

sketchybar --set "$NAME" icon="$ICON" icon.padding_right="$ICON_PADDING_RIGHT"
sketchybar --set "$NAME.name" label="$INFO"
