#!/bin/bash

# Window switcher — list all open windows, select to focus

selected=$(hyprctl clients -j | jq -r '.[] | "\(.pid):\(.class):\(.title)"' | \
  awk -F: '{printf "%s (%s)\n", $3, $2}' | \
  rofi -dmenu -i -p "Windows" -theme-str 'window {width: 50%;} listview {lines: 15;}')

if [ -z "$selected" ]; then
  exit 0
fi

# Extract PID from selection
pid=$(hyprctl clients -j | jq -r '.[] | select(.title == "'"${selected% (*}"'") | .pid' | head -1)

if [ -n "$pid" ]; then
  hyprctl dispatch focuswindow "pid:$pid"
fi
