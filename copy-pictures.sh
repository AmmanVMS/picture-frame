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

mkdir -p "$SOURCE"
touch "$SOURCE/picture-frame-recognized"

# for mount
sleep 1

( ( (
    set -e
    cd "`dirname \"$0\"`"
    echo "$0" "$@"
    # /home/pi/picture-frame/copy-pictures.sh sdc1
    device="$1"
    date
    echo "picture frame attached!"
    dir="`mktemp -d`"
    echo "created $dir, mounting $device"
    mount "/dev/$device" "$dir"
    echo "copy '$SOURCE' into '$dir'"
    cp -r "$SOURCE"/* "$dir"
    echo "copy '$log' into '$dir'"
    cp "$log" "$dir"
    echo "unmount '$dir' and sync"
    umount "$dir"
    sync
    # remove only if empty
    # see https://stackoverflow.com/a/23122112/1320237
    echo "removing $dir"
    rmdir "$dir"
  )
  echo "Exit code: $?"
) 2>&1 ) | tee "$log"

cp "$log" "$SOURCE"

