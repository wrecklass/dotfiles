#!/usr/bin/fish

set -gx EDITOR /usr/bin/vim
set -gx GOROOT /usr/lib/go
set -gx GOPATH $HOME/src/gocode
set -gx PATH $HOME/bin $GOPATH/bin $HOME/.cargo/bin $GOROOT/bin $PATH

if status --is-interactive
  abbr --add --global gco 'git checkout'
  abbr --add --global gs  'git status'
  abbr --add --global gbb 'git branches'
  abbr --add --global gbs 'git branches'
  abbr --add --global l   'less'
end
