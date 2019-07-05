PHONY := all

all: dotfiles vimfiles vimdocs

PHONY += submodules
submodules:
	git submodule init ./vim/pack
	git submodule update ./vim/pack

# Ignore the dotfiles in dotfiles
# Ignore Readme and Makefile
# Vim is handled below
PHONY += dotfiles
dotfiles:
	for file in $(shell find $(CURDIR) -maxdepth 1 -not -name ".[a-z]*" -not -name "README.md" -not -name "vim" -not -name "Makefile" -not -name "assh.yml"); do \
		f="$$(basename $$file)"; \
		ln -sfn $$file ~/.$$f; \
	done
	cp -f assh.yml ~/.ssh/assh.yml

# Vim requires a regular directory tree, it doesn't seem to accept a file link
# We kill it and recreate it each time, so everything has to be in the repo
PHONY += vimfiles
vimfiles: submodules
	rm -rf ~/.vim/
	cp -r ./vim ~/.vim/

PHONY += vimdocs
vimdocs:
	find "$(HOME)/.vim/" -type d -name doc -exec vim -u NONE -c "helptags {}" -c q \;

PHONY += help
help:
	@echo  'targets:'
	@echo  '  dotfiles    - install all of the dotfiles to HOME: [$(HOME)],'
	@echo  '                ignoring vim which must be copied'
	@echo  '  submodules  - clone the submodules to appropriate locations'
	@echo  '  vimfiles    - copy the vim directory to HOME/.vim: [$(HOME)/.vim/]'
	@echo  '  vimdocs     - create the vim module helptags'
	@echo  ''
