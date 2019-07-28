#!/bin/bash

cmd=${1:-'off'}
args=''
output=${2:-'HDMI-2'}

monitor_cmd="xrandr --output eDP-1 --mode 2560x1600 --output $output --mode 1920x1080 --scale 1.7x1.7"
echo "$monitor_cmd"

case "$cmd" in
    on|ON|dup|DUP)
        cmd="$monitor_cmd"
        ;;
    left|LEFT|l|L)
        cmd="$monitor_cmd --left-of eDP-1"
        ;;
    right|RIGHT|r|R)
        cmd="$monitor_cmd --right-of eDP-1"
        ;;
    above|ABOVE|a|A)
        cmd="$monitor_cmd --above eDP-1"
        ;;
    below|BELOW|b|B)
        cmd="$monitor_cmd --below eDP-1"
        ;;
    off|OFF)
        cmd="xrandr --output $output --off"
        ;;
    *)
        echo 'unknown command'
esac

echo "$cmd"
$cmd
