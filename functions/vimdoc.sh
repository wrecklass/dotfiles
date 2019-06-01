#!/bin/bash

function vimdoc() {
  find "$HOME/.vim/" -type d -name doc -exec vim -u NONE -c "helptags {}" -c q \;
}
