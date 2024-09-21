#!/bin/bash

alias help="_help"

function _help() {
  if builtin help "$1" &> /dev/null ; then
    builtin help "$1" | less
  elif "$1" --help &> /dev/null; then
    "$1" --help | less
  else
    man "$1"
  fi
  return 0
}
