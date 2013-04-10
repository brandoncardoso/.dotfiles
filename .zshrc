#!/bin/zsh

#Basic config
HISTFILE="${HOME}/.zsh_history"
HISTSIZE='10000'
SAVEHIST="${HISTSIZE}"
export EDITOR="/usr/bin/vim"
export TMP="$HOME/.tmp"
export TEMP="$TMP"
export TMPDIR="$TMP"
export TMPPREFIX="${TMPDIR}/zsh"
export SUDO_EDITOR="/usr/bin/vim -p -X"

# Functions
if [ -f '/etc/profile.d/prll.sh' ]; then
	. "/etc/profile.d/prll.sh"
fi

over_ssh() {
	if [ -n "${SSH_CLIENT}" ]; then
		return 0
	else
		return 1
	fi
}

reload () {
    exec "${SHELL}" "$@"
}

confirm() {
	local answer
	echo -ne "zsh: sure you want to run '${YELLOW}$@${NC}' [yN]? "
	read -q answer
	echo
	if [[ "${answer}" =~ ^[Yy]$ ]]; then
		command "${=1}" "${=@:2}"
	else
		return 1
	fi
}

confirm_wrapper() {
	if [ "$1" = '--root' ]; then
		local as_root='true'
		shift
	fi

	local runcommand="$1"; shift

	if [ "${as_root}" = 'true' ] && [ "${USER}" != 'root' ]; then
		runcommand="sudo ${runcommand}"
	fi
	confirm "${runcommand}" "$@"
}

poweroff() { confirm_wrapper --root $0 "$@"; }
reboot() { confirm_wrapper --root $0 "$@"; }
hibernate() { confirm_wrapper --root $0 "$@"; }

detox() {
	if [ "$#" -ge 1 ]; then
		confirm detox "$@"
	else
		command detox "$@"
	fi
}

has() {
	local string="${1}"
	shift
	local element=''
	for element in "$@"; do
		if [ "${string}" = "${element}" ]; then
			return 0
		fi
	done
	return 1
}

begin_with() {
	local string="${1}"
	shift
	local element=''
	for element in "$@"; do
		if [[ "${string}" =~ "^${element}" ]]; then
			return 0
		fi
	done
	return 1
}

termtitle() {
	case "$TERM" in
		rxvt*|xterm|nxterm|gnome|screen|screen-*)
		local prompt_host="${(%):-%m}"
		local prompt_user="${(%):-%n}"
		local prompt_char="${(%):-%~}"
	case "$1" in
		precmd)
		printf '\e]0;%s@%s: %s\a' "${prompt_user}" "${prompt_host}" "${prompt_char}"
		;;
		preexec)
		printf '\e]0;%s [%s@%s: %s]\a' "$2" "${prompt_user}" "${prompt_host}" "${prompt_char}"
		;;
	esac
		;;
		esac
}

preexec() {
# Set terminal title along with current executed command pass as second argument
	termtitle preexec "${(V)1}"
}

man() {
	if command -v vimmanpager >/dev/null 2>&1; then
		PAGER="vimmanpager" command man "$@"
	else
		command man "$@"
	fi
}

# Are we running under grsecurity's RBAC?
rbac_auth() {
	local auth_to_role='admin'
	if [ "${USER}" = 'root' ]; then
		if ! grep -qE '^RBAC:' "/proc/self/status" && command -v gradm > /dev/null 2>&1; then
			echo -e "\n${BLUE}*${NC} ${GREEN}RBAC${NC} Authorize to '${auth_to_role}' RBAC role."
			gradm -a "${auth_to_role}"
		fi
	fi
}
#rbac_auth

if [ ! -d "${TMP}" ]; then mkdir "${TMP}"; fi

if ! [[ "${PATH}" =~ "^${HOME}/bin" ]]; then
	export PATH="${HOME}/bin:${PATH}"
fi

#extended glob
setopt extendedGlob

autoload -U zmv
autoload -U zargs

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

#Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

autoload -U colors && colors
# Colors.
red='\e[0;31m'
RED='\e[1;31m'
green='\e[0;32m'
GREEN='\e[1;32m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
blue='\e[0;34m'
BLUE='\e[1;34m'
purple='\e[0;35m'
PURPLE='\e[1;35m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'

PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%} > %{$fg[blue]%}%~ %{$reset_color%}%# "
RPS1="$INSERT_INDICATOR"
RPS2=$RPS1

INSERT_INDICATOR="%{$fg[cyan]%}<<<%{$reset_color%}"
COMMAND_INDICATOR="%{$fg[yellow]%}<<<%{$reset_color%}"

function zle-line-init zle-keymap-select {
	RPS1="${${KEYMAP/vicmd/$COMMAND_INDICATOR}/(main|viins)/$INSERT_INDICATOR}"
	RPS2=$RPS1
	zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#aliases	
alias shutdown='sudo systemctl poweroff'
alias restart='sudo systemctl reboot'
alias sleep='sudo systemctl suspend'

alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'

function chpwd
{
	if [[ $(pwd) != $HOME ]]
	then
		ls --color=auto
	fi
}

alias sv='sudo vim'
alias v='vim'

alias mv='mv -i'
alias cp='cp -i'

alias playrct='sudo mount -o loop ~/.wine/cds/Roller_Coaster_Tycoon/Roller\ Coaster\ Tycoon\ Expansions.iso ~/.wine/drive_a && wine .wine/drive_c/Program\ Files\ \(x86\)/Hasbro\ Interactive/RollerCoaster\ Tycoon/RCT.EXE'

alias connect='wicd-curses'
alias pacman='sudo pacman'
alias update='pacman -Syu'
alias volume='alsamixer'
alias brightness='xbacklight -set'

alias mountusb='sudo mount -o gid=users,fmask=113,dmask=002 /dev/sdb1 /mnt/usb'
alias umountusb='sudo umount /mnt/usb'

alias grep='grep --color=auto'
alias df='df -h'

alias ls='ls -F --color=always'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'


alias nope='clear; cowsay -f stegosaurus Nope.'
alias urandom='base64 /dev/urandom | grep -i --color'
alias maze='ruby ~/school/cps506/assignments/2/maze.rb'

alias takenote='vim `date "+%y-%m-%d"`.txt'
alias schedule='feh ~/school/*schedule.png'
alias cal='cal -s3'

alias qwer='setxkbmap us -variant colemak'
alias qwfp='setxkbmap us'

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color
