#!/bin/bash

# detect HWMON path for cpu temp module
for i in /sys/class/hwmon/hwmon*/temp*_input; do
  if [ "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*}))" = "k10temp: Tdie" ]; then
    export HWMON_PATH="$i"
  fi
done

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
polybar bottom &

echo "Polybar launched..."
