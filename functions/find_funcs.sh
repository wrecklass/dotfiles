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
  if command -v bat &> /dev/null;then
    vim "$(fzf --preview="bat --color=always --decorations=always {}" --bind shift-up:preview-page-up,shift-down:preview-page-down)"
  else
    vim "$(fzf --preview="less {}" --bind shift-up:preview-page-up,shift-down:preview-page-down)"
  fi
}
