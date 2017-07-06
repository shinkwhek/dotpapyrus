all:
	make zplug
	make vimrc

zplug:
	cp ./.zshrc ~/
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

vimrc: .vimrc
	cp ./.vimrc ~/
	mkdir -p ~/.vim/bundle
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.vim/bundle
	rm ~/installer.sh

.PHONY: all zplug vimrc
