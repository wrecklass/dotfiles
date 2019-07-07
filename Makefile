# Project name
PROJECT_NAME=dotfiles

.DEFAULT_GOAL := deploy

.PHONY := deploy
deploy: dotfiles vimfiles vimdocs ## Install everything (default)

.PHONY := submodules
submodules: ## Pull in the git submodules
	git submodule init ./vim/pack
	git submodule update ./vim/pack

# Ignore the dotfiles in dotfiles
# Ignore Readme and Makefile
# Vim is handled below
.PHONY := dotfiles
dotfiles:                ## Install (link) the dotfiles
	for file in $(shell find $(CURDIR) -maxdepth 1 -not -name ".[a-z]*" -not -name "README.md" -not -name "vim" -not -name "Makefile" -not -name "assh.yml"); do \
		f="$$(basename $$file)"; \
		ln -sfn $$file ~/.$$f; \
	done
	cp -f assh.yml ~/.ssh/assh.yml

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
help:
	@echo 'Management commands for ${PROJECT_NAME}:'
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	 awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo

