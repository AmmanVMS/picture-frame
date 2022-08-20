#!/bin/bash
#
# copy the pictures into the photo frame
#
# see also https://askubuntu.com/questions/284224/autorun-a-script-after-i-plugged-or-unplugged-a-usb-device
# settings
# absolute path to the pictures
export SOURCE="/data/share/phone/picture-frame"

# constants
export log="$0.log"
export device="$1"

# for mount
sleep 1

( (
  if ! [ -d "$SOURCE" ]; then
    echo "source $SOURCE does not exist"
    exit
  fi
  touch "$SOURCE/picture-frame-recognized"
  if ! echo "$device" | grep -qE '^sd[a-z][0-9]$'; then
    echo "ignoring $device"
    exit
  fi
  (
    set -e
    cd "`dirname \"$0\"`"
    echo "$0" "$@"
    # /home/pi/picture-frame/copy-pictures.sh sdc1
    date
    echo "picture frame attached!"
    dir="`mktemp -d`"
    echo "created $dir, mounting $device"
    if mount "/dev/$device" "$dir"; then
      echo "copy '$SOURCE' into '$dir'"
      cp -r "$SOURCE"/* "$dir"
      echo "copy '$log' into '$dir'"
      cp "$log" "$dir"
      echo "unmount '$dir' and sync"
      umount "$dir"
      sync
    else
      echo "ERROR: could not mount $dev"
    fi
    # remove only if empty
    # see https://stackoverflow.com/a/23122112/1320237
    echo "removing $dir"
    rmdir "$dir"
  )
  echo "Exit code: $?"
) 2>&1 ) | tee -a "$log"

cp "$log" "$SOURCE"

