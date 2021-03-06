# Project name
PROJECT_NAME=dotfiles

.DEFAULT_GOAL := help

.PHONY := deploy
deploy: dotfiles fishconf vimfiles vimdocs ## Install everything, use this one to do it all

.PHONY := submodules
submodules:          ## Pull in the git submodules
	git submodule init ./vim/pack
	git submodule update ./vim/pack

# Ignore the dotfiles in dotfiles
# Ignore Readme and Makefile
# Fish and Vim is handled below
.PHONY := dotfiles
dotfiles:            ## Install (link) the dotfiles
	for file in $(shell find $(CURDIR) -maxdepth 1 -not -name ".[a-z]*" -not -name "README.md" -not -name "vim" -not -name "Makefile" -not -name "assh.yml" -not -name "fish"); do \
		f="$$(basename $$file)"; \
		ln -sfn $$file ~/.$$f; \
	done
	# ln -sfn $$PWD/assh.yml ~/.ssh/
	cp ./assh.yml ~/.ssh/


# Fish goes to the .config dir
.PHONY := fishconf
fishconf:            ## link fish to the $HOME/.config/ directory
	@echo Linking fish
	mkdir -p $$HOME/.config
	ln -sfn $$PWD/fish $$HOME/.config/

# Vim requires a regular directory tree, it doesn't seem to accept a file link
# We kill it and recreate it each time, so everything has to be in the repo
.PHONY := vimfiles
vimfiles: submodules ## Copy vim files to $HOME/vim
	rm -rf ~/.vim/
	cp -r ./vim ~/.vim/

.PHONY := vimdocs
vimdocs:             ## Create the vim helptags
	find "$(HOME)/.vim/" -type d -name doc -exec vim -u NONE -c "helptags {}" -c q \;

.PHONY := help
help:                ## List targets (default)
	@echo 'Management commands for ${PROJECT_NAME}:'
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	 awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo

