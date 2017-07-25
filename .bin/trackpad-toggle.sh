#!/bin/bash

DEVICE="DLL075B:01 06CB:76AF Touchpad"

enabledString=$(xinput list-props "$DEVICE" | grep "Device Enabled")
enabled=false
if [ "${enabledString: -1}" -eq "1" ]
  then
    enabled=true
fi

setVal=1
if [ "$enabled" = true ]; then
  setVal=0
fi

xinput --set-prop "$DEVICE" "Device Enabled" "$setVal"
