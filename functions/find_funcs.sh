#!/bin/bash

alias ff='_ff'
alias ffd='_ffd'
alias ffl='_ffl'
alias ffn='_ffn'
alias vif='_vifzf'
alias vifind='_vifind'
alias grepr="_grepr"
alias greprl="_greprl"
alias greplr="_greprl"
alias grepri="_grepri"
alias grepir="_grepri"
alias grepril="_grepril"
alias greprli="_grepril"

_grepr() {
  grep --exclude-dir vim --exclude-dir target --exclude-dir vendor --exclude-dir .git -r "$*" .
}

_greprl() {
  grep --exclude-dir vim --exclude-dir target --exclude-dir vendor --exclude-dir .git -rl "$*" .
}

_grepri() {
  grep --exclude-dir vim --exclude-dir target --exclude-dir vendor --exclude-dir .git -ri "$*" .
}

_grepril() {
  grep --exclude-dir vim --exclude-dir target --exclude-dir vendor --exclude-dir .git -ril "$*" .
}

_ff() {
    if [ $# -eq 0 ];then
        FF_DIR="."
    else
        FF_DIR="$1"
    fi
    find "${FF_DIR}" -type f
}

_ffd() {
    if [ $# -eq 0 ];then
        FF_DIR="."
    else
        FF_DIR="$1"
    fi
    find "${FF_DIR}" -type d
}

_ffl() {
    if [ $# -eq 0 ];then
        FF_DIR="."
    else
        FF_DIR="$1"
    fi
    find "${FF_DIR}" -type f -ls
}

_ffn() {
    find . -type f -name "$1"
}

# shellcheck disable=SC2046
_vifind() {
  if [[ -n "$1" ]];then
    vi $(find . -name "$1")
  fi
}

_vifzf() {
  local _tt
  local _bat

  _bat="$(command -v batcat)"
  if [ -z "$_bat" ]; then
    _bat="$(command -v bat)"
  fi

  if [ -n "$_bat" ]; then
    _tt="$(fzf -q "$1" --preview="$_bat --color=always --decorations=always {}" --bind shift-up:preview-page-up,shift-down:preview-page-down)"
  else
    _tt="$(fzf -q "$1" --preview="less {}" --bind shift-up:preview-page-up,shift-down:preview-page-down)"
  fi

  # Passes a set of Null/zero separated strings
  _tt="$(echo "$_tt" | tr '^0' ' ')"
  if [ -n "$_tt" ]; then
    vim $_tt
  fi
}

# See if fd is installed
# if not see if fdfind is installed and
# give it a function (alias) to fd if so
FD="$(command -v fd)"
if [ -z "$FD" ]; then
  FD="$(command -v fdfind)"
  if [ -n "$FD" ]; then
    function fd {
      fdfind "$@"
    }
  fi
fi
