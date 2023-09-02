#!/usr/bin/env bash

REL_DIR=`dirname $0`
cd $REL_DIR

PROFILE_DIR=`pwd -P`

cd $HOME

ln -s "$PROFILE_DIR/bash_profile" .bash_profile
ln -s "$PROFILE_DIR/tmux.conf" .tmux.conf
ln -s "$PROFILE_DIR/vimrc" .vimrc

VIM_DIR="$HOME/.vim/bundle" 
mkdir -p "$VIM_DIR"

VUNDLE_DIR="$VIM_DIR/Vundle.vim"
if ! [ -d $VUNDLE_DIR ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
	vim +PluginInstall +qall
fi

