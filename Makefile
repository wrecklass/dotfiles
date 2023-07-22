# Project name
PROJECT_NAME=dotfiles

.DEFAULT_GOAL := help

.PHONY := deploy
deploy: dotfiles fishconf windot vimfiles vimdocs ## Install everything, use this one to do it all

# Ignore the dotfiles in dotfiles
# Ignore Readme and Makefile
# Fish and Vim is handled below
.PHONY := dotfiles
dotfiles:            ## Install (link) the dotfiles
	for file in $(shell find $(CURDIR) -maxdepth 1 ! -name windows ! -name tags ! -name dotfiles ! -name "config.omp.*" ! -name ".[a-zA-Z]*" ! -name "README.md" ! -name "vim" ! -name "Makefile" ! -name "assh.yml" ! -name "fish"); do \
		f="$$(basename $$file)"; \
		ln -sfn $$file ~/.$$f; \
	done
	cp ./assh.yml ~/.ssh/

.PHONY := windot
windot:              ## Install windows versions of files if on Windows
	if [ -d /c/Users/smartin ]; then\
	  cp ./windows/vimrc /c/Users/smartin/.vimrc;\
	fi
	if [ -d /c/Users/smartin/AppData/Local/clink ]; then\
	  cp windows/oh-my-posh.lua /c/Users/smartin/AppData/Local/clink;\
	fi
	if [ -d /c/Users/smartin/AppData/Local/nvim ]; then\
	  cp windows/init.vim /c/Users/smartin/AppData/Local/nvim;\
	fi

# Fish goes to the .config dir
.PHONY := fishconf
fishconf:            ## link fish to the $HOME/.config/ directory
	@echo Linking fish
	mkdir -p $$HOME/.config
	ln -sfn $$PWD/fish $$HOME/.config/

# Vim requires a regular directory tree, it doesn't seem to accept a file link
.PHONY := vimfiles
vimfiles: ## Copy vim files to $HOME/.vim, Warning: $HOME/.vim is deleted first!
	if [ -d ~/.vim ] ;then \
		rm -rf ~/.vim/ ; \
	fi
	mkdir -p ~/.cache/undodir
	curl -fLo ~/.vim/docs/learnvim.txt --create-dirs https://raw.githubusercontent.com/dahu/LearnVim/master/doc/learnvim.txt
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	PATH="/usr/local/bin:/sbin:/bin:/usr/bin:/usr/lib/lapack:" vim -c "PlugInstall" -c qa \; </dev/zero

.PHONY := vimdocs
vimdocs:             ## Create the vim helptags
	find "$(HOME)/.vim/" -type d -name doc -exec vim -u NONE -c "helptags {}" -c q \;

.PHONY := nvim
nvim: nvim/init.vim                ## Create PowerShell nvim init.vim
	if [ -d /c/Users/smartin/AppData/Local ]; then \
	  mkdir -p /c/Users/smartin/AppData/Local/nvim ; \
	  rm -f /c/Users/smartin/AppData/Local/nvim/init.vim ; \
	  cp ./nvim/init.vim /c/Users/smartin/AppData/Local/nvim/ ; \
	fi

.PHONY := fzf
fzf:                ## Install fzf completions to the proper location
	if [ ! -r /usr/share/bash-completion/completions/fzf ];then \
	  cp functions/fzf.off /usr/share/bash-completion/completions/fzf ; \
	fi

.PHONY := help
help:                ## List targets (default)
	@echo 'Management commands for ${PROJECT_NAME}:'
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	 awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo
# vim: ts=4 sw=2
