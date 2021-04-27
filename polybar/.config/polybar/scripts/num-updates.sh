#!/bin/bash

icon="%{T3}%{T}"
numUpdates=$(apt-get -s -o Debug::NoLocking=true upgrade | grep ^Inst | wc -l)

if [[ numUpdates -gt 0 ]]; then
	echo "%{F#50fa7b}$icon $numUpdates%{F-}"
fi
