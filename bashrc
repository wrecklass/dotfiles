#!/bin/bash
# ulimit -u 1024
# If not running interactively, don't do anything

case $- in
	*i*) ;;
	*) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# The idea is to have a .bashrc file that can
# be used on any *nix type system be it OS X,
# linux or cygwin. The specific environment stuff
# gets added from external files based on which
# OS we find.

export NETREGX="[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
# Make sure we only source this once
[[ -z ${CYG_HOME_BASHRC} ]] && CYG_HOME_BASHRC="1" || return 0

UNAMECMD=$(which uname)
: ${HOME=~}
: ${UNAME=$($UNAMECMD)}
# Change various versions of CYGWIN_NT-XX.X to just 'cygwin' 
# To make sourcing our defaults environment easier.
UNAME=${UNAME/CYGWIN*/cygwin}
export UNAME

# Variables specific to the OS environment
if [ -d "${HOME}/.shenv" ];then
  for file in ${HOME}/.shenv/*${UNAME} ; do
    [[ -r "${file}" ]] && source "${file}" || echo WTF
  done
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias vdir='vdir --color=auto'
fi

export PATH

shopt -s cdspell
shopt -s nocaseglob
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
shopt -s autocd

if [ -r /etc/bash_completion ];then
  source /etc/bash_completion
fi

# Get our aliases
# if [ -r ${HOME}/.bash_aliases ];then
# source ${HOME}/.bash_aliases
# else
# echo "Missing ${HOME}/.bash_aliases file"
# echo "Make sure the file hasn't been moved or changed."
# fi

# Get our functions
if [ -d "${HOME}/.functions/" ];then
  for file in ${HOME}/.functions/*
  do
    [ -r "${file}" ] && . "${file}"
  done
else
  echo "Missing ${HOME}/.functions directory"
  echo "Make sure the directory hasn't been moved or changed."
fi

