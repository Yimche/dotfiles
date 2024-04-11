#!/bin/bash

foobar () {
  if [[ -n "$(pgrep foobar2000)" ]]; then
    title_line=$(hyprctl clients | grep '\[foobar2000\]' | grep title)
    if [[ $title_line =~ title:\ (.*)\ :\ (.*)\ \[foobar2000\] ]]; then
      if [[ ${BASH_REMATCH[2]} = "Playing " ]]; then
        out="  ${BASH_REMATCH[1]}"
        echo -n "$out"
      # echo -n $(
      # jq --unbuffered --compact-output --args \
      #   --arg title "$out" \
      #   -n '{text: $title, class: "playing"}'
      # )
      fi
    fi
  else
    out=$(python "$HOME/.config/waybar/lastfm.py" | sed 's/None$//g')
    if [[ $out != "" ]]; then
      echo -n "$out"
      # echo -n $(
      # jq --unbuffered --compact-output --args \
      #   --arg title "$out" \
      #   -n '{text: $title, class: "playing"}'
      # )
    else
      echo -n "$out"
      # echo -n $(
      # jq --unbuffered --compact-output --args \
      #   --arg title "$out" \
      #   -n '{text: $title, class: "stopped"}'
      # )
    fi
  fi
}

#playerctl

playing=$(playerctl status 2> /dev/null)
if [ "$playing" == "Playing" ]; then
  artist=$(playerctl metadata artist)
  song=$(playerctl metadata title)
  trackId=$(playerctl metadata mpris:trackid)
  out="  $artist - $song"  
  if [ "$trackId" != "'/org/mpris/MediaPlayer2/firefox'" ]; then
      echo -n "$out"
    # echo -n $(
    # jq --unbuffered --compact-output --args \
    #   --arg title "$out" \
    #   -n '{text: $title, class: "playing"}'
    #   )
  fi
else
  foobar
fi

