#!/bin/bash

switchTo=$1

if [[ $(hyprctl monitors | grep "active workspace" | grep $switchTo | wc -l) == 1 ]]; then
  if [[ $(hyprctl activeworkspace | grep -Eo "ID [0-9]*([0-9])" | grep -Eo "[0-9]*([0-9])") != "$switchTo" ]]; then
    hyprctl dispatch swapactiveworkspaces current +1
  fi
else
  hyprctl dispatch moveworkspacetomonitor $switchTo current
  hyprctl dispatch workspace $switchTo
fi
