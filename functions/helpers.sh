#!/bin/bash

alias help="_help"

function _help() {
  builtin help "$1" 2> /dev/null || "$1" --help | less
  return 0
}
