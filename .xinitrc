xrdb -merge ~/.Xresources

#screen powersave
xset +dpms
xset dpms 0 0 300

xset +fp /usr/share/fonts/local
xset fp rehash &

/usr/bin/urxvt -q -o -f &
setxkbmap -option caps:none

feh --bg-center ~/.dotfiles/train.jpg &
xbacklight -set 7 &
unclutter &
udiskie &
xbindkeys &
#(sleep 1s && conky | dzen2 -x '720' -w '640' -h '15' -e '' -fg '#000000' -bg '#ffffff' -ta r -fn '-*-envy code r-*-*-*-*-13-*-*-*-*-*-*-*' -p ) &
conky | while read -r; do xsetroot -name "$REPLY"; done &

while true; do
	# Log stderror to a file
	dwm 2> ~/.dwm.log
	# No error logging
	#dwm >/dev/null s>&1
done
