#!/bin/bash

##ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", DEVPATH=="/devices/pci0000:00/0000:00:01.0/0000:01:00.0/drm/card0", RUN+="/home/julian/.config/hypr/nvidia-monitors.sh enable"
##ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="0", DEVPATH=="/devices/pci0000:00/0000:00:01.0/0000:01:00.0/drm/card0", RUN+="/home/julian/.config/hypr/nvidia-monitors.sh disable"

control=$1

if [[ $control == "enable" ]]; then
  rateOffset=1000
elif [[ $control == "disable" ]]; then
  rateOffset=0
else
  exit
fi

if [[ $(nvidia-smi) > $(/dev/null 2>&1) ]]; then
  #echo "$(date): Configuring NVIDIA GPU settings..." >> /var/log/manage_gpu.log
  nvidia-settings -a [gpu:0]/GPUMemoryTransferRateOffset[3]=$rateOffset
else
  #echo "$(date): NVIDIA GPU tools not found. Check your GPU setup."
fi
