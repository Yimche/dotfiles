#!/bin/sh

if [[ $(xrandr -q | grep "^HDMI-1 connected" | wc -l) == 1 ]]; then
  xrandr --output "eDP-1" --primary --mode 1920x1080 --pos 0x0 --rotate normal --output "HDMI-1" --mode 1280x1024 --pos 1920x0 --rotate normal 
  $(xmobar -x 1 ~/.config/xmobar/xmobarrc1)
elif [[ $(xrandr -q | grep "^DP-1 connected" | wc -l) == 1 ]]; then
  xrandr --output "eDP-1" --primary --mode 1920x1080 --pos 0x0 --rotate normal --output "DP-1" --mode 1280x1024 --pos 1920x0 --rotate normal 
  $(xmobar -x 1 ~/.config/xmobar/xmobarrc1)
else
  xrandr --output "eDP-1" --primary --mode 1920x1080 --pos 0x0 --rotate normal --output "HDMI-1" --off --output "DP-1" --off
fi
