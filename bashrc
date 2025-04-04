#!/bin/bash
# Author: Stephen Martin
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

# ulimit -u 1024
# Only source this once, unless TMUX
if [ -z "$TMUX" ]; then
  [[ -z "${BASH_RC}" ]] && readonly BASH_RC=true || return 0
fi

case $- in
*i*) ;;
*) return ;;
esac
# }}}
# {{{ Logging
if [[ -z $WSL ]]; then
  export LANG="en_US.UTF-8"
  export LC_ALL="C.UTF-8"
fi
ORIGPATH="$PATH"
UNAMECMD=$(command -v uname)
if [ -z "$UNAMECMD" ]; then
  if [ -x /bin/uname ]; then
    UNAMECMD=/bin/uname
  elif [ -x /usr/bin/uname ]; then
    UNAMECMD=/usr/bin/uname
  fi
fi

declare -x MTYPE='Win'
if grep -q BCM /proc/cpuinfo &>/dev/null; then
  MTYPE='Ras'
fi
# UNAMECMD="/usr/bin/uname"
declare -x -l UNAME
: "${HOME=~}"
: "${UNAME=$($UNAMECMD -o)}"
# export UNAME
if [ "${UNAME}" = "cygwin" ]; then
  PATH="/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/lib/lapack:$PATH"
fi

if [[ -z "$USER" ]]; then
  USER="$(/usr/bin/id -un)"
fi

if [[ -z "$HOSTNAME" ]]; then
  HOSTNAME="$(/usr/bin/hostname)"
fi

# Change various versions of CYGWIN_NT-XX.X to just 'cygwin'
# To make sourcing our defaults environment easier.
# UNAME="${UNAME/cygwin*/cygwin}"
# change "gnu/linux" to just "linux"
UNAME="${UNAME/*linux/linux}"

# Set =1 for verbose output
declare -x -i VERBOSE=0

if [[ -f "$HOME/.verbose" ]]; then
  VERBOSE=1
fi

if [ ! -d "$HOME/.logs" ]; then
  mkdir -p "$HOME/.logs"
fi
if [ -n "$PS1" ]; then
  _log() {
    if [ "$VERBOSE" -eq 1 ]; then
      dt="$(date)"
      printf "%s-%s: %s\n" "${dt}" "BASHRC[$$]" "$*"
    fi
  }
else
  _log() {
    if [ "$VERBOSE" -eq 1 ]; then
      dt="$(date)"
      printf "%s-%s: %s\n" "${dt}" "BASHRC[$$]" "$*" >>"$HOME/.logs/bashrc.log"
    fi
  }
fi
_log ".bashrc"
_log "USER: $USER"
_log "UNAME: $UNAME"
_log "MTYPE: $MTYPE"
# _log "PATH: $PATH"
# }}}
# {{{ shopts

set -o vi

if [[ -o emacs ]]; then
  _log "emacs mode"
elif [[ -o vi ]]; then
  _log "vi mode"
else
  _log "neither vi or emacs mode is set."
fi

shopt -s cdspell
shopt -s dirspell
shopt -s nocaseglob
shopt -s hostcomplete
shopt -s no_empty_cmd_completion
# Older version of Bash may not like this one:
shopt -s autocd &>/dev/null

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

# For grepping our IP addresses
export IPV4_REGX="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

# export BAT_THEME="Solarized (dark)"
export BAT_THEME="ansi"

# Deprecated:
# export NETREGX="[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

export IPV6_REGX='(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))'

# History variables are in .functions/history

# export LSCOLORS='Gxfxcxdxdxegedabagacad'
# export CDPATH=".:~:~/src"
export ORIGPATH
# export PATH
export LESS='FXrj5'
[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"

# Make sure we only source this once
# [[ -z "${CYG_HOME_BASHRC}" ]] && CYG_HOME_BASHRC="1" || return 0
# }}}
# {{{ shenv for different environments
# Variables specific to the OS environment
FZF=$(command -v fzf)
ZOXIDE=$(command -v zoxide)
for file in "${HOME}"/.shenv/*."${UNAME}"; do
  _log "Sourcing ${file}"

  # Only do this if zoxide is installed
  if [[ "${file}" =~ "zoxide" ]] && [[ -z "${ZOXIDE}" ]]; then
    _log "zoxide not installed"
    continue
  fi
  if [[ -r "${file}" ]]; then
    source "${file}"
  else
    _log "No such file: ${file}"
  fi
done
# }}}
# {{{ bash_completion

if [ -r "/usr/share/bash-completion/bash_completion" ]; then
  source "/usr/share/bash-completion/bash_completion"
elif [ -r "/usr/local/etc/bash_completion" ]; then
  source "/usr/local/etc/bash_completion"
elif [ -r "/etc/bash_completion" ]; then
  source "/etc/bash_completion"
else
  _log "No bash_completion script!"
fi

# This completion is not sourced until git<TAB> is used from the command
# line. So we need to do it up front for our aliases
if [ -r "/usr/share/bash-completion/completions/git" ]; then
  source "/usr/share/bash-completion/completions/git"
elif [ -r "/usr/local/etc/completions/git" ]; then
  source "/usr/local/etc/completions/git"
elif [ -r "/etc/bash_completion.d/git" ]; then
  source "/etc/bash_completion.d/git"
else
  _log "No git completion script!"
fi

# completion for hub command
if [ -f "$GOPATH/src/github.com/github/hub/etc/hub.bash_completion" ]; then
  source "$GOPATH/src/github.com/github/hub/etc/hub.bash_completion"
fi

# }}}
# {{{ DIRCOLORS
# enable color support of ls and also add handy aliases
if command -v dircolors &>/dev/null; then
  if [ -r "${HOME}/.dircolors" ]; then
    eval "$(dircolors -b "${HOME}/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
  alias vdir='vdir --color=auto'
fi
# }}}
# {{{ Import our standard files and some specials
# Import all of the files we use
# Note that bash_prompt is a case by case basis per OS

PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\]"

for file in ~/.{bash_aliases,path,extra,exports,override}; do
  [[ -f "$file" ]] && _log ".bashrc file:${file}"
  [[ -r "$file" ]] && [[ -f "$file" ]] && source "$file"
done
unset file

# }}}
# {{{ Functions
# Get our functions
if [ -d "${HOME}/.functions/" ]; then
  for SCRIPT in "${HOME}"/.functions/*; do
    if [[ "${file}" =~ "fzf" ]] && [[ -z "${FZF}" ]]; then
      _log "Not sourcing ${file}"
      continue
    fi
    if [[ "${SCRIPT}" =~ "off" ]]; then
      _log "Not sourcing ${file}"
      continue
    fi
    if [[ "${SCRIPT}" =~ git-prompt.sh ]]; then
      _log "Not sourcing ${file}"
      # We source this later if we need it
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
# {{{ Appended by other programs
[[ -r "${HOME}/.fzf.bash" ]] && source ~/.fzf.bash

if type rg &>/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m'
fi
export FZF_COMPLETION_OPTS='--height=70% --info=inline --border'
# cd

GOC=$(command -v gocomplete)
if [ -n "$GOC" ]; then
  complete -C "$GOC" go
fi

# Cargo env
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

export BASH_RC
# }}}
# {{{ Figlet
if [ -n "$PS1" ]; then
  FIGLET=$(command -v figlet)
  if [ -n "${FIGLET}" ]; then
    "${FIGLET}" -tf smslant "Welcome  to"
    # "${FIGLET}" -tC upper -f slant "$HOSTNAME"
    "${FIGLET}" -tf big "$HOSTNAME"
  else
    printf "Welcome to $HOSTNAME\n"
  fi
fi
unset FIGLET
# }}}
# {{{ fortune
FORTUNE="$(command -v fortune)"
if [ -x "$FORTUNE" ]; then
  "$FORTUNE"
fi
unset FORTUNE
# }}}
# {{{ node
export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ]; then
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi
# }}}
#vim: set et sw=2 foldmethod=marker
