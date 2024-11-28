#!/usr/bin/env bash
IFS=$'\n'

# Get the list of outputs based on the description, which is what makes sense to a human
# and is what we want to show in the tofi selection menu
outsinks=""
for x in $(pactl list sinks | grep -ie "description:" | cut -d: -f2 | sed 's/Raptor Lake-P\/U\/H cAVS //g' | sort); do
  outsinks+="$x\n"
done
chosen="$(echo -e $outsinks | sed 's/^[[:space:]]*//' | tofi --config ~/.config/tofi/scripts/soundswitch)"

# Do nothing if null
if [[ $chosen == "" ]]; then exit; fi

# Figure out what the device name is based on the description passed
device=$(pactl list sinks | grep -C2 -F "Description:" | grep -C2 -F "$chosen" | grep Name | cut -d: -f2 | xargs)
# Try to set the default to the device chosen
if pactl set-default-sink "$device"; then
  # if it worked, alert the user
  dunstify -t 2000 -r 2 -u low "Activated: $chosen"
else
  # didn't work, critically alert the user
  dunstify -t 2000 -r 2 -u critical "Error activating $chosen"
fi
