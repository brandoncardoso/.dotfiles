xrdb -merge ~/.Xresources

#screen powersave
xset +dpms
xset dpms 0 0 300

xset +fp /usr/share/fonts/local
xset fp rehash &

/usr/bin/urxvt -q -o -f &
setxkbmap -option caps:none

feh --bg-center ~/.dotfiles/triangles.png &
xbacklight -set 7 &
unclutter &
udiskie &
conky | while read -r; do xsetroot -name "$REPLY"; done &
while true; do
	# Log stderror to a file
	dwm 2> ~/.dwm.log
	# No error logging
	#dwm >/dev/null s>&1
done
