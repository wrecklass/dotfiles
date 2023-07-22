#!/bin/bash

export HISTCONTROL='erasedups:ignoreboth'
export HISTIGNORE="x:fg:h:history:ls:ps:ll:exit"
export HISTSIZE=5000
export HISTFILESIZE=5000

_h () {
    if [ $# -gt 0 ]; then
        history | grep -i "$*"
    else
        history
    fi
}

alias h="_h"
