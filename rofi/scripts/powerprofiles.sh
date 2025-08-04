#!/usr/bin/env bash
rofi_command="rofi -theme $HOME/.config/rofi/themes/powerprofile.rasi"

# Options variable passed to rofi
performance="performance"
balanced="balanced"
powersave="power-saver"
options="$performance\n$balanced\n$powersave"

current=$(powerprofilesctl | sed -n 's/^\* \(.*\):/\1/p')
row=1

case $current in
$performance)
    row=0
    ;;
$balanced)
    row=1
    ;;
$powersave)
    row=2
    ;;
esac


chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row $row)"
#chosen="$(echo -e "$options" | tofi)"
case $chosen in
$performance)
    powerprofilesctl set performance
    ;;
$balanced)
    powerprofilesctl set balanced
    ;;
$powersave)
    powerprofilesctl set power-saver
    ;;
esac
