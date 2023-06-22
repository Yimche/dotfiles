#!/bin/sh
playing=$(echo -n $(playerctl status))

if [ "$playing" == "Playing" ]; then
  artist=$(playerctl metadata artist)
  song=$(playerctl metadata title)
  echo -n "$artist - $song"
elif [ "$playing" == "Stopped" ]; then
  echo "No media playing"
else
  echo -n "No player could handle this command"
fi
