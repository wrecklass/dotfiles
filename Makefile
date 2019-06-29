.PHONY: all dotfiles submodules vimfiles vimdocs

all: dotfiles vimfiles vimdocs

submodules:
	git submodule init ./vim/pack
	git submodule update ./vim/pack

# Ignore the dotfiles in dotfiles
# Ignore Readme and Makefile
# Vim is handled below
dotfiles:
	for file in $(shell find $(CURDIR) -maxdepth 1 -not -name ".[a-z]*" -not -name "README.md" -not -name "vim" -not -name "Makefile" -not -name "assh.yml"); do \
		f="$$(basename $$file)"; \
		ln -sfn $$file ~/.$$f; \
	done
	cp -f assh.yml ~/.ssh/assh.yml

# Vim requires a regular directory tree, it doesn't seem to accept a file link
# We kill it and recreate it each time, so everything has to be in the repo
vimfiles: submodules
	rm -rf ~/.vim/
	cp -r ./vim ~/.vim/

vimdocs:
	find "$(HOME)/.vim/" -type d -name doc -exec vim -u NONE -c "helptags {}" -c q \;
