# dotfiles

## My current dotfiles

The Makefile takes care of installing them to the correct place with the proper file names.  

Because vim doesn't seem to like a softlink on ~/.vim/ I copy the entire directory instead.  

Note that none of the files are preceded by a dot, to make them easier to see and edit on a Linux/Un\*x style system.  

*Note* that to make FZF and fzf.vim plugin work on Windows we need to clone the repo to $GOCODE/src/github.com/junegunn/fzf and link that to /usr/local/opt/fzf
That allows things to work properly in both Mac/Homebrew and Windows
