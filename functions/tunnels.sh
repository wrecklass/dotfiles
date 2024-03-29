#!/bin/bash

alias tmsh='tsh'
alias tmssh='tsh'
alias tmuxsh='tsh'

# Ssh to somewhere and attach or start a tmux session.
tsh () {
  if [[ -n "$1" ]];then
    ssh -t "$(dig +short @192.168.1.11 "$1")" 'tmux attach -t main || tmux new -s main'
  else
    printf "Error, must provide a host name for ssh\n"
  fi
}
