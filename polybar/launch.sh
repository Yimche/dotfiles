#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch bar
# for m in $(polybar --list-monitors | cut -d":" -f1); do
#   MONITOR=$m polybar --reload main &
#   MONITOR=$m polybar --reload monitor &
# done

polybar main &

if [[ $(xrandr -q | grep 'HDMI-1 connected') ]]; then
  sleep 3 && MONITOR="HDMI-1" polybar monitor &
fi

if [[ $(xrandr -q | grep '^DP-1 connected') ]]; then
  sleep 3 && MONITOR="DP-1" polybar monitor &
fi

