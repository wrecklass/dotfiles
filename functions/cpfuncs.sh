#!/bin/bash
# Functions for various copy alternatives

alias treecp='_treecp'
alias tarcp='_treecp'
alias rscp='_rscp'

alias cpi='_cpi'

function _treecp {
  if [ "$#" -ne 2 ];then
    printf "usage: %s directory1 directory2\n" "${FUNCNAME[0]}"
    return 2
  fi
  [ ! -d "$1" ] && return 2
  [ ! -d "$2" ] && return 2
  tar cf - "$1" | ( cd "$2" || return 1 ; tar xvf - )
}

function _cpi {
  if [ "$#" -ne 2 ];then
    printf "usage: %s directory1 directory2\n" "${FUNCNAME[0]}"
    return 2
  fi

  [ ! -d "$1" ] && return 2
  [ ! -d "$2" ] && return 2
  find "$1" -depth -print0 | cpio -B --null -pvd "$2"
}

function _rscp {
  dir=$(echo "$1" | sed -e 's/\/$//')
  rsync -avz "$dir" "$2"
}
