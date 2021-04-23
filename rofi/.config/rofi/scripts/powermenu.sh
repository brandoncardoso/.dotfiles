#! /bin/bash

power_off="Shutdown"
reboot="Restart"
lock="Lock"
logout="Logout"

typeset -A menu
menu=(
  [Shutdown]="shutdown 0"
  [Restart]="reboot"
  [Lock]="xset s activate"
  [Logout]="bspc quit"
)

ROFI_OPTIONS=(-config ~/.config/rofi/scripts/powermenu.rasi \
  -me-select-entry 'MousePrimary' \
  -me-accept-entry 'MouseDPrimary')

launcher_options=(-dmenu -i -lines "${#menu[@]}" "${ROFI_OPTIONS[@]}")

launcher=(rofi "${launcher_options[@]}")

selection="$(printf '%s\n' "${!menu[@]}" | sort -r | "${launcher[@]}")"

if [[ -n $selection ]]; then
  exec ${menu[${selection}]}
fi
