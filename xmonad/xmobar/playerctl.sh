#!/bin/bash
playing=$(echo -n $(playerctl status))

if [ "$1" != "" ]; then
  if [ "$playing" == "Playing" ]; then
    artist=$(playerctl metadata artist)
    song=$(playerctl metadata title)
    trackId=$(playerctl metadata mpris:trackid)
    if [ "$trackId" != "'/org/mpris/MediaPlayer2/firefox'" ]; then
    echo -n "$artist </fc><fc=#fff>-</fc><fc=#88c0d0> $song"
    else
      echo -n "$(date)"
    fi
  elif [ "$playing" == "Stopped" ]; then
    echo -n "$(date)"
  elif [[ -n "$(pgrep foobar2000)" ]]; then
    fb2kid=$(wmctrl -l -x | grep "foobar2000.exe.foobar2000.exe")
    if [[ $(echo $(xdotool getwindowname $fb2kid) | grep "v2.0" | wc -l) -ge 1 ]]; then
      echo -n "$(date)"
    else
      echo -n "$(xdotool getwindowname $fb2kid | awk -F ' - ' '{ split($2, arr, "] "); gsub(/\s*\[foobar2000\]/, "", arr[2]); print $1 " - " arr[2] }')"
    fi
  else
    echo -n "$(date)"
  fi
fi

