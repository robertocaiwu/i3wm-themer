#!/bin/bash
 
while true
do
  if [ -e /sys/class/power_supply/BAT1/uevent ]; then
    paste /sys/class/power_supply/BAT0/uevent /sys/class/power_supply/BAT1/uevent | awk '{split($0,a,"="); split(a[2],b," "); (a[3] == "Charging" || b[1] == "Charging") ? $5 = "Charging" : $5 = (a[3] + b[1])/2; print a[1] "=" $5}' > /tmp/.uevent
  else
    cat /sys/class/power_supply/BAT0/uevent > /tmp/.uevent
  fi    
  sleep 5
done
