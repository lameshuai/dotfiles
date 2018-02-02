#!/bin/bash
function install_prepare_software() {

	sudo apt-get install -y git gcc g++
	rm -rf ~/.gitconfig
	cp .gitconfig ~

}

function install_tmux() {

	sudo apt-get install -y tmux
	sudo apt-get install -y powerline
	git clone https://github.com/powerline/fonts ~/fonts
	~/fonts/install.sh
	rm -rf ~/.tmux.conf
	rm -rf ~/.tmux.conf.local
	cp .tmux.conf ~
	cp .tmux.conf.local ~

}

function install_zsh() {

	sudo apt-get install -y zsh
        chsh -s /bin/zsh
	rm -rf ~/.zshrc
	cp .zshrc ~
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
   	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

}

function install_neovim() {

	sudo apt-get install -y neovim vim-gtk3 vim-youcompleteme python3-pip ctags
	sudo pip3 install --upgrade neovim

	rm -rf ~/.vimrc
	rm -rf ~/.vimrc.plugin
	rm -rf ~/.vimrc.conf
	rm -rf ~/.ycm_extra_conf.py
	rm -rf ~/.vim
	mkdir ~/.vim
	cp .vimrc ~
	cp .vimrc.plugin ~
 	cp .vimrc.conf ~
	cp .ycm_extra_conf.py ~
	ln -s ~/.vim ~/.config/nvim
	ln -s ~/.vimrc ~/.config/nvim/init.vim

	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    	nvim -c "PluginInstall" -c "qa"

   	git clone https://github.com/ryanoasis/nerd-fonts ~/nerd-fonts
	~/nerd-fonts/install.sh

}

function main() {

	install_prepare_software
	install_tmux
	install_zsh
	install_neovim

}

main
