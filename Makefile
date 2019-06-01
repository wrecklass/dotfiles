.PHONY: all dotfiles submodules vimfiles vimdocs

all: dotfiles vimfiles vimdocs

submodules:
	git submodule init ./vim/pack
	git submodule update ./vim/pack

dotfiles:
	for file in $(shell find $(CURDIR) -maxdepth 1 -not -name "README.md" -not -name "vim" -not -name ".git*" -not -name "dotfiles" -not -name "Makefile"); do \
		f="$$(basename $$file)"; \
		ln -sfvn $$file ~/.$$f; \
	done

vimfiles: submodules
	rm -rf ~/.vim/
	cp -r ./vim ~/.vim/

vimdocs:
	find "$(HOME)/.vim/" -type d -name doc -exec vim -u NONE -c "helptags {}" -c q \;
