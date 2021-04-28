#!/usr/bin/sh
# only add floating scratchpad window node id to /tmp/scratchid
#bspc query -N -n .floating | xargs -i sh -c 'bspc query --node {} -T | grep -q scratchpad && echo {} > /tmp/scratchid'
echo "$(xdo id -n scratchpad)" > /tmp/scratchid
TMPFILE=$(mktemp)
d=$(date +%Y-%m-%d)
echo "source ~/.bashrc" >> $TMPFILE
echo "mkdir -p ~/notes" >> $TMPFILE
echo "cd ~/notes" >> $TMPFILE
echo "nvim ~/notes/${d}.txt" >> $TMPFILE
exec $SHELL --rcfile $TMPFILE
