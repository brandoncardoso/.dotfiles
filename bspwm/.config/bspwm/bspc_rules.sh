#! /bin/bash

bspc rule -a Yad state=floating layer=above
bspc rule -a Steam state=floating focus=off
bspc rule -a mpv state=floating
bspc rule -a discord desktop=^4
bspc rule -a qBittorrent state=floating desktop=^5
bspc rule -a Pavucontrol state=floating
bspc rule -a Org.gnome.Nautilus state=floating
bspc rule -a Pcmanfm state=floating
bspc rule -a Zathura state=tiled
bspc rule -a Gnome-calculator state=floating

steamlib=~/.local/share/Steam    # path to your steamlibrary
mygames="$(ls $steamlib/steamapps/appmanifest_*.acf | sed 's/[^0-9]*//g')"    # this sed command removes everything but the digits

for game in $mygames; do
    bspc rule -a steam_app_$game state=fullscreen layer=above
done

# scratchpad
bspc rule -a "Alacritty:scratchpad" sticky=on state=floating
