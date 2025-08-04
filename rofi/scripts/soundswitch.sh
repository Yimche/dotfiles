#!/usr/bin/env bash
rofi_command="rofi -i -theme $HOME/.config/rofi/themes/soundswitch.rasi"

prompt="\x00prompt\x1fSelect Output\n"
# Show only relevant outputs and exclude other HDMI ones except for HDMI / DisplayPort 1 Output
options=$(pactl list sinks | awk -F': ' '
  tolower($1) ~ /description/ {
    desc = $2
    gsub(/Raptor Lake-P\/U\/H cAVS /, "", desc)
    if (desc ~ /HDMI/ && desc != "HDMI / DisplayPort 1 Output") next
    print desc
  }
' | grep . | sort)

chosen="$(echo -e "$options" | $rofi_command -p "$prompt" -dmenu -selected-row 0)"

if [[ -z $chosen ]]; then
    exit
fi

device=$(pactl list sinks | grep -C2 -F "Description:" | grep -C2 -F "$chosen" | grep Name | cut -d: -f2 | xargs)

echo $device
if pactl set-default-sink "$device"; then
  # if it worked, alert the user
  dunstify -t 2000 -r 2 -u low "Activated: $chosen"
else
  # didn't work, critically alert the user
  dunstify -t 2000 -r 2 -u critical "Error activating $chosen"
fi

