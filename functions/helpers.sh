#!/bin/bash

alias help="_help"
alias clr='clear-only-screen'

function _help() {
  if builtin help "$1" &>/dev/null; then
    builtin help "$1" | less
  elif "$1" --help &>/dev/null; then
    "$1" --help | less
  else
    man "$1"
  fi
  return 0
}

clear-only-screen() {
  printf "\e[H\e[2J"
}

clear-screen-and-scrollback() {
  printf "\e[H\e[3J"
}

clear-screen-saving-contents-in-scrollback() {
  printf "\e[H\e[22J"
}
