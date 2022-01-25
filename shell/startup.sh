#!/bin/sh

echo `date`

sudo powertop --auto-tune

sudo bash -c 'echo on > /sys/bus/usb/devices/1-2/power/control'
sudo bash -c 'echo on > /sys/bus/usb/devices/1-3/power/control'
sudo bash -c 'echo on > /sys/bus/usb/devices/1-4/power/control'
