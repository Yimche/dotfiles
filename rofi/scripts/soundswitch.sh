#!/usr/bin/env bash
# Outputs have spaces in them, so let's make \n the IFS
IFS=$'\n'

# An option was passed, so let's check it
if [ "$@" ]; then
  # the output from the selection will be the desciption.  Save that for alerts
  desc="$*"
  # Figure out what the device name is based on the description passed
  device=$(pactl list sinks | grep -C2 -F "Description:" | grep -C2 -F "$desc" | grep Name | cut -d: -f2 | xargs)
  # Try to set the default to the device chosen
  if pactl set-default-sink "$device"; then
    # if it worked, alert the user
    dunstify -t 2000 -r 2 -u low "Activated: $desc"
  else
    # didn't work, critically alert the user
    dunstify -t 2000 -r 2 -u critical "Error activating $desc"
  fi
else
  echo -en "\x00prompt\x1fSelect Output\n"
  # Get the list of outputs based on the description, which is what makes sense to a human
  # and is what we want to show in the menu
  #for x in $(pactl list sinks | grep -ie "description:" | cut -d: -f2 | sed 's/ Tiger Lake-LP Smart Sound Technology Audio Controller //g' | sort); do
  for x in $(pactl list sinks | grep -ie "description:" | cut -d: -f2 | sed 's/Raptor Lake-P\/U\/H cAVS //g' | sort); do
    # outputs with cut may have spaces, so use empty xargs to remove them, and output that to the rofi list
    echo "$x" | xargs -0
  done
fi
