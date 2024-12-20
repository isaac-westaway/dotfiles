#!/bin/sh

ln -s ~/configs/vim/.vimrc ~/.vimrc &&
ln -s ~/configs/vim/.vim ~/.vim &&
ln -s ~/configs/zsh/.zshrc ~/.zshrc &&
ln -s ~/configs/zsh/zsh ~/zsh

cd ~ &&
mkdir build_files &&
cd build_files &&
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git &&
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

