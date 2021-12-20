#!/bin/bash
# Symlinks configuration files to their correct location. 
# Careful as it completely replaces any existing configuration.

ln -s -f $(pwd)/config ~/.i3/config
ln -s -f $(pwd)/.vimrc ~/.i3/.vimrc
mkdir -p ~/.config/nvim && ln -s -f $(pwd)/init.vim ~/.config/nvim/init.vim
ln -s -f $(pwd)/.bashrc ~/.bashrc
ln -s -f $(pwd)/.tmux.conf ~/.tmux.conf
ln -s -f $(pwd)/.Xresources ~/.Xresources
ln -s -f $(pwd)/.Xmodmap ~/.Xmodmap
ln -s -f $(pwd)/.Xdefaults ~/.Xdefaults
