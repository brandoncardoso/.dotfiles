#! /bin/bash
## check if scratchpad is already running, launch if not
[ "$(ps -x | grep -c 'scratchpad')" -eq "1" ] && alacritty --class scratchpad --title scratchpad -e ~/.config/bspwm/scratchpad.sh &
