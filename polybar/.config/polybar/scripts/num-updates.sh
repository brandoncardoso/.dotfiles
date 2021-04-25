#!/bin/bash

icon="%{T3}%{T}"
numUpdates=$(apt-get -s -o Debug::NoLocking=true upgrade | grep ^Inst | wc -l)

if [[ numUpdates -gt 0 ]]; then
	echo "%{F#50fa7b}$icon $numUpdates%{F-}"
else
	echo "%{F#6272a4}$icon $numUpdates%{F-}"
fi
