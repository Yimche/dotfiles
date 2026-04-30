#!/usr/bin/env bash

# Run hyprctl to get window information, and pass it to tofi
selected=$(hyprctl clients -j | jq -r '
    .[] | "[\(.workspace.id)] \(.class) | \(.title)\t\(.workspace.id)\t\(.address)"
    ' | sort | rofi -dmenu -i -p "window:" -display-columns 1)

# Check if the user pressed Escape (i.e., tofi produces an empty result)
[ -z "$selected" ] && exit 0

# Focus the window with the selected title
ws=$(printf "%s" "$selected" | awk -F'\t' '{print $2}')
addr=$(printf "%s" "$selected" | awk -F'\t' '{print $3}')

hyprctl dispatch focusworkspaceoncurrentmonitor "$ws"
hyprctl dispatch focuswindow address:$addr
