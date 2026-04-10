#!/bin/bash

export HISTCONTROL='erasedups:ignoreboth'
export HISTIGNORE="alias:cls:clear:date:dir:dot:x:fg:h*:history*:ls:ll:ps:exit"
export HISTSIZE=5000
export HISTFILESIZE=5000

_h () {
    if [ $# -gt 0 ]; then
      declare -i I="$*"
      if [[ $I > 0 ]]; then
        history | tail -n "$I"
      else
        history | grep -i "$*"
      fi
    else
        history
    fi
}

alias h="_h"
