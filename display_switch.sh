#!/bin/bash

temp_file=$(mktemp)

if [ $1 = "l" ]
then
    echo "Xft.dpi: 144" >> "$temp_file"
    xrandr --output eDP1 --auto
    xrandr --output HDMI1 --off
    xrandr --size 2256x1504
elif [ $1 = "m" ]
then
    echo "Xft.dpi: 96" >> "$temp_file"
    xrandr --output HDMI1 --auto
    xrandr --output eDP1 --off
    xrandr --size 1920x1080
else
    echo "Invalid argument passed"
fi

xrdb -merge "$temp_file"
i3 restart

rm "$temp_file"
