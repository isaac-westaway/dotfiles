#!/bin/sh

# clean up github clonse
mv ~/dotfiles/configs ~/configs

echo "updating symlinks"

[ -L ~/.vimrc ] && rm ~/.vimrc
ln -s ~/configs/vim/.vimrc ~/.vimrc

[ -L ~/.vim ] && rm -rf ~/.vim
ln -s ~/configs/vim/.vim ~/.vim

[ -L ~/.zshrc ] && rm ~/.zshrc	
ln -s ~/configs/zsh/.zshrc ~/.zshrc

[ -L ~/zsh ] && rm -f ~/zsh
ln -s ~/configs/zsh/zsh ~/zsh

echo "doing build files"
if [ -d ~/build_files]; then
	cd ~/build_files
else
	mkdir ~/build_files
fi

if [ ! zsh-autocomplete ]; then
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
else
	echo "zsh autocomplete exists"
fi
		
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rm -rf dotfiles
