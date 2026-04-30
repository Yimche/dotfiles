##!/usr/bin/env bash
rofi_command="rofi -i -theme $HOME/.config/rofi/themes/soundswitch.rasi"

prompt="\x00prompt\x1fSelect Output\n"

options=$(pactl list sink-inputs | awk -F' = ' -v maxlen=20 '
/application.name/ {app=$2}
/media.name/ {
    media=$2
    gsub(/^"• Discord \| /, "\"", media)   # remove leading "• Discord | "
    gsub(/ Application/, "", app)
    gsub(/"/, "", media)
    gsub(/"/, "", app)

    if (length(media) > maxlen) media = substr(media, 1, maxlen-1) "…"

    print app " \t| " media
}' | sort)

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
