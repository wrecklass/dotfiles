#!/bin/bash

if [[ "$HISTFILE" =~ "tty" ]];then
  ## Forced appending
  cat $HOME/.bash_history "$HISTFILE" | tail -n 10000 > ~/.bash_history.tmp
  \mv -f $HOME/.bash_history.tmp ~/.bash_history

  # Doesn't seem to work:
  #export HISTFILE="$HOME/.bash_history"
  #builtin history -a
  #export HISTFILESIZE=50000
  echo "Buh-bye"
  sleep 1
fi

