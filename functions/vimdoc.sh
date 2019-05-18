#!/bin/bash

function vimdoc() {
  local dir
  cd $HOME/.vim/
  for dir in $(find ./pack -name doc); do
    echo vim -u NONE -c "helptags ${dir}" -c q
    vim -u NONE -c "helptags ${dir}" -c q
  done
  cd -
}
