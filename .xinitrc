xrdb -merge ~/.Xresources

#screen powersave
xset +dpms
xset dpms 0 0 300

xset +fp /usr/share/fonts/local
xset fp rehash &

/usr/bin/urxvt -q -o -f &
setxkbmap -option caps:none

feh --bg-fill ~/.dotfiles/candh.jpg &
xbacklight -set 7 &
unclutter &
udiskie &
xbindkeys &
(sleep 3s && conky | dzen2 -x '880' -w '480' -h '15' -e '' -fg '#000000' -bg '#fbfbfb' -ta r -fn '-*-envy code r-*-*-*-*-12-*-*-*-*-*-*-*' -p ) &
#conky | while read -r; do xsetroot -name "$REPLY"; done &

while true; do
	# Log stderror to a file
	dwm 2> ~/.dwm.log
	# No error logging
	#dwm >/dev/null s>&1
done
