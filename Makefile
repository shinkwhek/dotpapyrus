
ZSHRC = .zshrc
EMACS = .emacs.d
VIM   = .vimrc

all:
	make install

install: Makefile
	make zsh
	make vim
	make emacs

zsh_update: $(ZSHRC)
	echo -e "\e[31;1;4mset zshrc\e[m"
	cp ./$(ZSHRC) ~/

zsh: Makefile $(ZSHRC)
	make zsh_update
	echo -e "\e[32;1mInstall\e[m \e[35;1;4mzplug\e[m\e[32;1m.!!!\e[m"
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

emacs_update_init_el: $(EMACS)/init.el
	cp $(EMACS)/init.el ~/.emacs.d/

emacs_update: $(EMACS)
	echo -e "\e[31;1;4mset emacs\e[m"
	cp -r $(EMACS) ~/

emacs: Makefile $(EMACS)
	make emacs_update

vim_update: $(VIM)
	echo -e "\e[31;1;4mset vimrc\e[m"
	cp ./$(VIM) ~/

vim: Makefile $(VIM)
	make vim_update
	echo -e "\e[31;1mcreate ~/.vim/bundle\e[m"
	mkdir -p ~/.vim/bundle
	echo -e "\e[32;1mInstall\e[m \e[37;1;4mdein\e[m"
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.vim/bundle
	echo -e "\e[36;1mClean~~~\e[m"
	rm ./installer.sh

update: zsh_update emacs_update vim_update


PHONY: all zsh emacs vim install update purge emacs_update_init_el
