.PHONY: all bin dotfiles etc

all: bin dotfiles etc

dotfiles:
	for file in $(shell find $(CURDIR) -maxdepth 1 -not -name "README.md" -not -name "vim" -not -name ".git" -not -name "dotfiles" -not -name "Makefile"); do \
		f="$$(basename $$file)"; \
		ln -sfn $$file ~/.$$f; \
	done
	rm -rf ~/.vim
	cp -r ./vim ~/.vim/
