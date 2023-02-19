dotfiles
========

## My current dotfiles

The `Makefile` takes care of installing everything to the correct place with the proper file names.
Perform a `make help` or simple `make` alone to see what specific job targets are.

Because `vim` doesn't seem to like a soft-link on `~/.vim/`, I copy the entire directory instead.
Plugins and docs will be updated with the *vimfiles* and *vimdocs* `make` targets.

*Note* that none of these files are preceded by a dot, to make them easier to see
and edit on a Linux/Un\*x style system. Dots are added during the deployment
phase. Target is *dotfiles*.

