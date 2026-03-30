#!/usr/bin/env bash
rofi_command="rofi -theme $HOME/.config/rofi/themes/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
if [[ "$DIR" == "powermenu" ]]; then
  shutdown=""
  reboot=""
  lock=""
  suspend=""
  logout=""
  ddir="$HOME/.config/rofi/scripts/powermenu"
else

  # For some reason the Icons are mess up I don't know why but to fix it uncomment section 2 and comment section 1 but if the section 1 icons are mess up uncomment section 2 and comment section 1

  # Buttons
  layout=$(cat $HOME/.config/rofi/scripts/powermenu.sh | grep BUTTON | cut -d'=' -f2 | tr -d '[:blank:],*/')
  if [[ "$layout" == "TRUE" ]]; then
    # Section 1
    #shutdown=""
    #reboot=""
    #lock=""
    #suspend=""
    #logout=""
    # Section 2
    shutdown="襤"
    reboot="ﰇ"
    lock=""
    suspend="鈴"
    logout=""
  else
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
  fi
  ddir="$HOME/.config/rofi/scripts/powermenu"
fi

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 0)"
#chosen="$(echo -e "$options" | tofi)"
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
  hyprlock &
  systemctl suspend
  ;;
$logout)
  exit
  ;;
esac
