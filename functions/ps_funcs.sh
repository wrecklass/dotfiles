#!/bin/bash

alias psg='_psg'
alias psgi='_psgi'
alias psgc='_psgc'
alias psl='_psl'
alias psn='_psn'
alias psw='tasklist'

_psg() {
    pgrep -lf "$*"
}

_psgi() {
    pgrep -lfi "$*"
}

# shellcheck disable=2009
_psgc() {
    ps auxw | grep -i "$*" | grep -v grep
}

_psl() {
    tasklist /v | grep -i "$*"
}


_psn() {
    tasklist | sed 's/,//g' | sort --sort=h -k 5
}
