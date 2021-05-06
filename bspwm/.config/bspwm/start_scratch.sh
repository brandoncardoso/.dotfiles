#! /bin/bash
## check if scratchpad is already running, launch if not
if [ "$(ps -x | grep -c 'scratchpad')" -eq "1" ]; then
    alacritty --class scratchpad --title scratchpad -e ~/.config/bspwm/scratchpad.sh
fi
