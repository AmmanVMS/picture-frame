#!/bin/bash
#
# copy the pictures into the photo frame
#
# see also https://askubuntu.com/questions/284224/autorun-a-script-after-i-plugged-or-unplugged-a-usb-device

cd "`dirname \"$0\"`"

# for mount
sleep 1

( (
  date
  echo "picture frame attached!"

) 2>&1 ) | tee "`basename \"$0\"`.log"

