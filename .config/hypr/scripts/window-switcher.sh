#!/bin/bash

# Window switcher — list all open windows, select to focus

windows=$(hyprctl clients -j | jq -r '.[] | "\(.pid):\(.class):\(.title)"')
count=$(echo "$windows" | wc -l)
lines=$((count > 15 ? 15 : count))

selected=$(echo "$windows" | \
  awk -F: '{printf "%s (%s)\n", $3, $2}' | \
  rofi -dmenu -i -p "Windows" -theme-str "window {width: 50%;} listview {lines: $lines;}")

if [ -z "$selected" ]; then
  exit 0
fi

# Extract PID from selection
pid=$(hyprctl clients -j | jq -r '.[] | select(.title == "'"${selected% (*}"'") | .pid' | head -1)

if [ -n "$pid" ]; then
  hyprctl dispatch focuswindow "pid:$pid"
fi
