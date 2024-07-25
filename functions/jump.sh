#!/usr/bin/env bash
export MARKPATH=$HOME/.marks

function mark {
        mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

function unmark {
        rm -i "$MARKPATH/$1"
}

function marks {
        echo && ls -l --color=yes "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' | column -t && echo
}

function jump {
        if [ -z "$1" ]; then
          marks
        else
          builtin cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
        fi
}
alias j='jump'

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}
complete -F _completemarks jump j unmark

