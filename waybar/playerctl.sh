#!/bin/bash

lastfm () {
    out=$(python "$HOME/.config/waybar/lastfm.py" | sed 's/None$//g')
    if [[ $out != "" ]]; then
      # echo -n "$out"
      echo -n $(
      jq --unbuffered --compact-output --args \
        --arg title "$out" \
        -n '{text: $title, class: "playing"}'
      )
    else
      # echo -n "$out"
      echo -n $(
      jq --unbuffered --compact-output --args \
        --arg title "$out" \
        -n '{text: $title, class: "stopped"}'
      )
    fi
}

foobar () {
    title_line=$(hyprctl clients | grep '\[foobar2000\]' | grep title)
    if [[ $title_line =~ title:\ (.*)\ :\ (.*)\ \[foobar2000\] ]]; then
      if [[ ${BASH_REMATCH[2]} = "Playing " ]]; then
        out="  ${BASH_REMATCH[1]}"
        # echo -n "$out"
        echo -n $(
        jq --unbuffered --compact-output --args \
          --arg title "$out" \
          -n '{text: $title, class: "playing"}'
        )
      else
        spotify
      fi
    else
      spotify
    fi
}

spotify () {
  status=$(playerctl status)
  if [[ $status == "Playing" ]]; then
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    trackid=$(playerctl metadata mpris:trackid)
    if [[ ($trackid != "'/org/mpris/MediaPlayer2/firefox'") ]]; then
      out="  $artist - $title"
      echo -n $(
      jq --unbuffered --compact-output --args \
        --arg title "$out" \
        -n '{text: $title, class: "playing"}'
      )
    else
      lastfm
    fi
  else
    lastfm
  fi
}


if [[ -n $(pgrep foobar2000) ]]; then
  foobar
elif [[ -n $(pgrep spotify) ]]; then
  spotify
else
  lastfm
fi

