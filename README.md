# Picture Frame

This is a service that runs on the Raspberry Pi in the MakerSpace.
It has the following purpose:

When the picture frame is attached, it copies all pictures from a certain
folder into the storage of the picture frame.

## Setup

Get the id of the picture frame:

```
$ lsusb
Bus 001 Device 031: ID 1b8e:0021 Amlogic, Inc. Picture Frame
```

Edit the `00-usb-picture-frame.rules`:
- absolute path - `/home/pi/picture-frame/00-usb-picture-frame.in`
- vendor id - `1b8e`
- device id - `0021`
- username - `pi`

Then, install the udev rule:

```
sudo cp 00-usb-picture-frame.rules /etc/udev/rules.d
```

Then, edit the sudoers file to not use a password and add this line
replacing the "absolute path" as before:

```
username  ALL=(ALL) NOPASSWD: /home/pi/picture-frame/00-usb-picture-frame.in
```

Then, edit `copy-pictures.sh`:
```
export SOURCE="..."
```

## Related Work

- debug udev: https://unix.stackexchange.com/questions/461684/udev-rules-not-running
- https://askubuntu.com/questions/401390/running-a-script-when-connecting-a-usb-device



