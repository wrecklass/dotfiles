#!/bin/bash
# ulimit -u 1024
# {{{ Notes

# The idea is to have a .bashrc file that can
# be used on any *nix type system be it OS X,
# linux or cygwin. The specific environment stuff
# gets added from external files based on which
# OS we find.
# }}}
# {{{ Interactivity checks
# If not running interactively, don't do anything
# shellcheck disable=SC1090
# shellcheck disable=SC1091

# Only source this once
[[ -z "${BASH_RC}" ]] && BASH_RC="1" || return 0
case $- in
  *i*) ;;
  *) return;;
esac
# }}}
# {{{ Logging
declare -x -i VERBOSE=0

_log() {
    if [ "$VERBOSE" -eq 1 ];then
      dt="$(date)"
      printf "%s-%s: %s\n" "${dt}" "BASHRC[$$]" "$*"
    fi
}

_log ".bashrc"
# }}}
# {{{ shopts

shopt -s cdspell
shopt -s dirspell
shopt -s nocaseglob
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
# Older version of Bash may not like this one:
shopt -s autocd &> /dev/null

# Show expanded command before executing
# Do the 'Are you sure' thing like ZSH
shopt -s histverify
shopt -s histreedit
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# }}}
# {{{ Export variables

# History variables are in .functions/history

# export NETREGX="[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"
# Better:
export NETREGX="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
export LSCOLORS='Gxfxcxdxdxegedabagacad'
# export CDPATH=".:~:~/src"
export ORIGPATH="${PATH}"
export PATH
export LESS='FXR'
[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"

# Make sure we only source this once
# [[ -z "${CYG_HOME_BASHRC}" ]] && CYG_HOME_BASHRC="1" || return 0

UNAMECMD=$(command -v uname)
: "${HOME=~}"
: "${UNAME=$($UNAMECMD -s | tr '[:upper:]' '[:lower:]')}"
# Change various versions of CYGWIN_NT-XX.X to just 'cygwin' 
# To make sourcing our defaults environment easier.
UNAME="${UNAME/cygwin*/cygwin}"
export UNAME
# }}}
# {{{ shenv for different environments
# Variables specific to the OS environment
for file in "${HOME}"/.shenv/*."${UNAME}" ; do
  FZF=$(command -v fzf)
  if [[ "${file}" =~ "fzf" ]] && [[ -z "${FZF}" ]]; then
    _log "Not sourcing ${file}"
    continue
  fi

  _log "Sourcing ${file}"
 
  if [[ -r "${file}" ]]; then
    source "${file}"
  else
    _log "No such file: ${file}"
  fi
done
# }}}
# {{{ DIRCOLORS
# enable color support of ls and also add handy aliases
if command -v dircolors > /dev/null 2>&1; then
  if [ -r "${HOME}/dircolors" ];then
    eval "$(dircolors -b "${HOME}/dircolors")" 
  else
    eval "$(dircolors -b)"
  fi
  alias vdir='vdir --color=auto'
fi
# }}}
# {{{ bash_completion

if [ -r "/usr/share/bash-completion/bash_completion" ];then
  source "/usr/share/bash-completion/bash_completion"
elif [ -r "/usr/local/etc/bash_completion" ];then
  source "/usr/local/etc/bash_completion"
elif [ -r "/etc/bash_completion" ];then
  source "/etc/bash_completion"
else
  _log "No bash_completion script!"
fi

# completion for hub command
if [ -f "$GOPATH/src/github.com/github/hub/etc/hub.bash_completion" ]; then
  source "$GOPATH/src/github.com/github/hub/etc/hub.bash_completion"
fi

# }}}
# {{{ Import our standard files and some specials
# Import all of the files we use
# Note that bash_prompt is a case by case basis per OS
for file in ~/.{bash_aliases,path,extra,exports,override}; do
  _log ".bash_profile file:${file}"
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file
# }}}
# {{{ Functions
# Get our functions
if [ -d "${HOME}/.functions/" ];then
  for SCRIPT in "${HOME}"/.functions/*; do
    if [[ "${SCRIPT}" =~ "off" ]];then
      continue
    fi
    [ -r "${SCRIPT}" ] && source "${SCRIPT}"
  done
else
  _log "Missing ${HOME}/.functions directory"
  _log "Make sure the directory hasn't been moved or changed."
fi

unset UNAMECMD
# }}}

[[ -r "${HOME}/.fzf.bash" ]] && source ~/.fzf.bash || echo ""

GOC=$(command -v gocomplete)
if [ -n "$GOC" ];then
  complete -C $GOC go
fi

# vim: set et sw=2 foldmethod=marker
