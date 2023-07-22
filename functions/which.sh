#!/bin/bash
WHICH='/bin/which'
if [[ ! -x "$WHICH" ]];then
  WHICH='/usr/bin/which'
fi
if [[ ! -x "$WHICH" ]];then
  return 1
fi

_which() {
  TR=''
  All=''
  if [[ "$1" = "-a" ]];then
    All='-a'
    shift
  fi
  if [ "$#" -ge 1 ]; then
    if [[ -n "$WHICH" ]];then
      TR=$(${WHICH} "$All" "$@" 2>/dev/null)
    fi
    if [[ -z "$TR" ]]; then
      TR=$(type -P "$@")
      if [ -z "$TR" ];then
        TR=$(type "$@")
      fi
    fi
    echo "$TR"
  else
    return 1
  fi
}
alias which="_which"
