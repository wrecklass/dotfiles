#!/bin/bash
# ulimit -u 1024
# If not running interactively, don't do anything
# shellcheck disable=SC1090
# shellcheck disable=SC1091

case $- in
  *i*) ;;
  *) return;;
esac

VERBOSE=0

log() {
    if [ $VERBOSE -eq 1 ];then
      dt=$(date)
      echo "${dt}-BASHRC[$$]: $*"
    fi
}

log '.bashrc'

# DigitalOcean Token:
export TOKEN='fa3acf68894c3e9e6448989865e92c4c219e2b8f9174a3aec798d32556c75730'

CDPATH="~:~/src"

shopt -s cdspell
shopt -s dirspell
shopt -s nocaseglob
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
# Older version of Bash may not like this one:
shopt -s autocd &> /dev/null

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# The idea is to have a .bashrc file that can
# be used on any *nix type system be it OS X,
# linux or cygwin. The specific environment stuff
# gets added from external files based on which
# OS we find.

# export NETREGX="[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
# Better:
export NETREGX="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
export LESS='FXR'
export LSCOLORS='Gxfxcxdxdxegedabagacad'

# Make sure we only source this once
# [[ -z ${CYG_HOME_BASHRC} ]] && CYG_HOME_BASHRC="1" || return 0

UNAMECMD=$(command -v uname)
: ${HOME=~}
: ${UNAME=$($UNAMECMD -s | tr '[:upper:]' '[:lower:]')}
# Change various versions of CYGWIN_NT-XX.X to just 'cygwin' 
# To make sourcing our defaults environment easier.
UNAME="${UNAME/cygwin*/cygwin}"
export UNAME

# Variables specific to the OS environment
for file in "${HOME}"/.shenv/*."${UNAME}" ; do
  [[ -r "${file}" ]] && source "${file}" || printf "No such file: %s\n" "${file}"
done

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if [ -r ~/.dircolors ];then
    eval "$(dircolors -b ~/.dircolors)" 
  else
    eval "$(dircolors -b)"
  fi
  alias vdir='vdir --color=auto'
fi

export PATH

if [ -r /usr/share/bash-completion/bash_completion ];then
  source /usr/share/bash-completion/bash_completion
elif [ -r /usr/local/etc/bash_completion ];then
  source /usr/local/etc/bash_completion
elif [ -r /etc/bash_completion ];then
  source /etc/bash_completion
else
  log "No bash_completion script!"
fi

# Import all of the files we use
#for file in ~/.{bash_prompt,bash_aliases,path,extra,exports}; do
for file in ~/.{bash_aliases,path,extra,exports}; do
  log ".bash_profile file:${file}"
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

# Get our functions
if [ -d "${HOME}/.functions/" ];then
  for SCRIPT in "${HOME}"/.functions/*; do
    if [[ "${SCRIPT}" =~ ".settitle" ]];then
      continue
    fi
    [ -r "${SCRIPT}" ] && source "${SCRIPT}"
  done
else
  log "Missing ${HOME}/.functions directory"
  log "Make sure the directory hasn't been moved or changed."
fi

unset UNAMECMD

