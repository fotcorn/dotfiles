#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

pkill -f nm-applet
pkill -f unity-settings-daemon

unity-settings-daemon &
polybar example &
nm-applet &

