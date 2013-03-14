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

source ~/.scripts/zsh_prompt/git_info.zsh

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

git_check_if_worktree() {
# This function intend to be only executed in chpwd().
# Check if the current path is in git repo.

# We would want stop this function, on some big git repos it can take some time to cd into.
	if [ -n "${skip_zsh_git}" ]; then
		git_pwd_is_worktree='false'
		return 1
	fi
# The : separated list of paths where we will run check for git repo.
# If not set, then we will do it only for /root and /home.
	if [ "${UID}" = '0' ]; then
# running 'git' in repo changes owner of git's index files to root, skip prompt git magic if CWD=/home/*
		git_check_if_workdir_path="${git_check_if_workdir_path:-/root}"
	else
		git_check_if_workdir_path="${git_check_if_workdir_path:-/home}"
		git_check_if_workdir_path_exclude="${git_check_if_workdir_path_exclude:-${HOME}/_sshfs}"
	fi

	if begin_with "${PWD}" ${=git_check_if_workdir_path//:/ }; then
		if ! begin_with "${PWD}" ${=git_check_if_workdir_path_exclude//:/ }; then
			local git_pwd_is_worktree_match='true'
		else
			local git_pwd_is_worktree_match='false'
		fi
	fi

	if ! [ "${git_pwd_is_worktree_match}" = 'true' ]; then
		git_pwd_is_worktree='false'
		return 1
	fi

# todo: Prevent checking for /.git or /home/.git, if PWD=/home or PWD=/ maybe...
# damn annoying RBAC messages about Access denied there.
	if [ -d '.git' ] || [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
		git_pwd_is_worktree='true'
		git_worktree_is_bare="$(git config core.bare)"
	else
		unset git_branch git_worktree_is_bare
		git_pwd_is_worktree='false'
	fi
}

git_branch() {
	git_branch="$(git symbolic-ref HEAD 2>/dev/null)"
	git_branch="${git_branch##*/}"
	git_branch="${git_branch:-no branch}"
}

git_dirty() {
	if [ "${git_worktree_is_bare}" = 'false' ] && [ -n "$(git status --untracked-files='no' --porcelain)" ]; then
		git_dirty='%F{green}*'
	else
		unset git_dirty
	fi
}

precmd() {
# Set terminal title.
	termtitle precmd

	if [ "${git_pwd_is_worktree}" = 'true' ]; then
		git_branch
		git_dirty

		git_prompt=" %F{blue}[%F{253}${git_branch}${git_dirty}%F{blue}]"
	else
		unset git_prompt
	fi
}

preexec() {
# Set terminal title along with current executed command pass as second argument
	termtitle preexec "${(V)1}"
}

chpwd() {
	git_check_if_worktree
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

# Check if we started zsh in git worktree, useful with tmux when your new zsh may spawn in source dir.
git_check_if_worktree

if [ "${git_pwd_is_worktree}" = 'true' ]; then
	git_branch
	git_dirty
	git_prompt=" %F{blue}[%F{253}${git_branch}${git_dirty}%F{blue}]"
else
	unset git_prompt
	fi

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

PROMPT="%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%} > %{$fg[yellow]%}%c%{$reset_color%}$git_prompt_info%# "
RPS1="$INSERT_INDICATOR"
RPS2=$RPS1

INSERT_INDICATOR="%{$fg[cyan]%}<<<%{$reset_color%}"
COMMAND_INDICATOR="%{$fg[yellow]%}<<<%{$reset_color%}"


# git theming default: Variables for theming the git info prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}<"
ZSH_THEME_GIT_PROMPT_SUFFIX="> %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*" # Text to display if the branch is dirty
ZSH_THEME_GIT_PROMPT_UNTRACKED="$"
ZSH_THEME_GIT_PROMPT_AHEAD="+"
ZSH_THEME_GIT_PROMPT_CLEAN="^" # Text to display if the branch is clean
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

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias connect='wicd-curses'
alias pacman='sudo pacman-color'
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
