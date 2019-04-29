#!/bin/bash

if [[ "$HISTFILE" =~ "tty" ]];then
  ## Forced appending
  # Just use a tmp file and ignore .bash_history for now.
  cat $HOME/.bash_history_tmp "$HISTFILE" | tail -n 5000 > ~/.bash_history.tmp
  mv -f $HOME/.bash_history.tmp $HOME/.bash_history_tmp
  rm -f "$HISTFILE"

  # Doesn't seem to work:
  #export HISTFILESIZE=50000
  echo "Buh-bye"
  sleep 1
fi

