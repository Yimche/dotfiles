#!/usr/bin/env bash

# Run hyprctl to get window information, and pass it to tofi
selected_title=$(hyprctl clients -j | jq -r '.[] | [ .title, .class, .pid ] | join(" | ")' | sort |
  tofi --prompt-text="window: ")

# Check if the user pressed Escape (i.e., tofi produces an empty result)
if [ -z "$selected_title" ]; then
  # Do nothing if Escape was pressed or if no selection was made
  exit 0
fi

# Extract the title from the selected string
title=$(echo "$selected_title" | awk '{print $1}')

# Focus the window with the selected title
hyprctl dispatch focuswindow title:"$title"
