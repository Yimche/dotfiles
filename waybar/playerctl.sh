#!/bin/bash

foobar () {
  if [[ -n "$(pgrep foobar2000)" ]]; then
    title_line=$(hyprctl clients | grep '\[foobar2000\]' | grep title)
    if [[ $title_line =~ title:\ (.*)\ \[foobar2000\] ]]; then
      echo -n "  ${BASH_REMATCH[1]}"
    fi
  fi
}

mpd () {
  if [[ -n "$(pgrep mpd)" ]]; then
    formatted_title="$(mpc status | grep -m1 "")"
    if [[ $formatted_title =~ .*"n/a".* ]]; then
      echo -n ""
    else
      echo -n "  $formatted_title"
    fi
  fi
}

#playerctl
playing=$(playerctl status 2> /dev/null)
if [ "$playing" == "Playing" ]; then
  artist=$(playerctl metadata artist)
  song=$(playerctl metadata title)
  trackId=$(playerctl metadata mpris:trackid)
  if [ "$trackId" != "'/org/mpris/MediaPlayer2/firefox'" ]; then
    echo -n "  $artist - $song"
  else
    foobar
    mpd
  fi
elif [ "$playing" == "Paused" ]; then
  artist=$(playerctl metadata artist)
  song=$(playerctl metadata title)
  trackId=$(playerctl metadata mpris:trackid)
  if [ "$trackId" != "'/org/mpris/MediaPlayer2/firefox'" ]; then
    echo -n "  $artist - $song"
  else
    foobar
    mpd
  fi
else
  foobar
  mpd
fi

