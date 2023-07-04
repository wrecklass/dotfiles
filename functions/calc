#!/usr/bin/env bash
# Simple calculator
#
alias centigradetofahrenheit='c2f'
alias fahrenheittocentigrade='f2c'

alias centtofahr='c2f'
alias fahrtocent='f2c'

calc() {
  local result=""
  result="$(echo "scale=10;$*" | bc --mathlib | tr -d '\\\n')"
  #                        └─ default (when --mathlib is used) is 20


  if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "%s" "_$result" | \
    sed -e 's/^\./0./' \
      -e 's/^-\./-0./' \
      -e 's/0*$//;s/\.$//' \
      -e 's/_//g';
  else
    printf "%s" "$result"
  fi
  printf "\n"
}

c2f() {
  [[ -z $1 ]] && return
  calc "32+($1*9/5)"
}

f2c() {
  [[ -z $1 ]] && return
  calc "($1-32)*5/9"
}
