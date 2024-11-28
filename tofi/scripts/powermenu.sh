#!/usr/bin/env bash
uptime=$(uptime -p | sed -e 's/up //g')

# Options
# Buttons
# Section 1
#shutdown=""
#reboot=""
#lock=""
#suspend=""
#logout=""
# Section 2
# shutdown="襤"
# reboot="ﰇ"
# lock=""
# suspend="鈴"
# logout=""
# Section 1
# shutdown=" Shutdown"
# reboot=" Restart"
# lock=" Lock"
# suspend=" Sleep"
# logout=" Logout"
# Section 2
shutdown="󰐥 Shutdown"
reboot="󰑙 Reboot"
lock=" Lock"
suspend="󰒲 Suspend"
logout="󰍃 Logout"
ddir="$HOME/.config/tofi/scripts/powermenu"

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

#chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 0)"
chosen="$(echo -e "$options" | tofi --config ~/.config/tofi/scripts/powermenu)"
case $chosen in
$shutdown)
  systemctl poweroff
  ;;
$reboot)
  systemctl reboot
  ;;
$lock)
  swaylock
  ;;
$suspend)
  sh "$HOME/code_Master/scripts/fb2k.sh pp"
  swaylock -f
  systemctl suspend
  ;;
$logout)
  exit
  ;;
esac
