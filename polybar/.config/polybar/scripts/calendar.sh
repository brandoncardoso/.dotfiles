#!/bin/sh

YAD_WIDTH=300 # 222 is minimum possible value
YAD_HEIGHT=200 # 193 is minimum possible value
DATE="$(date +'%a,  %b %e,  %Y    %l:%M:%S %p')"

case "$1" in --popup)
	yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons --posx=2246 --posy=1190 \
		--title="Calendar" --borders=0 --width=$YAD_WIDTH --height=$YAD_HEIGHT >/dev/null &
	;;
*)
	echo "$DATE"
	;;
esac
