DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
ZSHRC = .zshrc
EMACS = .emacs.d
VIM   = .vimrc

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

install: deploy init ## Run make, deploy, init
	@exec $$SHELL

clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)


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

vim: Makefile
	echo -e "\e[31;1mcreate ~/.vim/bundle\e[m"
	mkdir -p ~/.vim/bundle
	echo -e "\e[32;1mInstall\e[m \e[37;1;4mdein\e[m"
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.vim/bundle
	echo -e "\e[36;1mClean~~~\e[m"
	rm ./installer.sh


PHONY: all zsh emacs vim install update purge emacs_update_init_el
