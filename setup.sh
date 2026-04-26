#!/usr/bin/env bash

set -e

REL_DIR=`dirname $0`
cd $REL_DIR

PROFILE_DIR=`pwd -P`

cd $HOME

link_if_missing() {
  local target="$1"
  local link="$2"
  if [ -L "$link" ] || [ -e "$link" ]; then
    echo "skip: $link already exists"
  else
    ln -s "$target" "$link"
    echo "linked: $link -> $target"
  fi
}

#link_if_missing "$PROFILE_DIR/bash_profile" "$HOME/.bash_profile"
link_if_missing "$PROFILE_DIR/tmux.conf"    "$HOME/.tmux.conf"
link_if_missing "$PROFILE_DIR/zshrc"        "$HOME/.zshrc"

mkdir -p "$HOME/.config/nvim"
link_if_missing "$PROFILE_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "installing oh-my-zsh"
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# oh-my-zsh custom plugins (third-party plugins referenced in zshrc)
OMZ_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
clone_omz_plugin() {
  local name="$1" repo="$2" dest="$OMZ_CUSTOM/plugins/$1"
  if [ ! -d "$dest" ]; then
    echo "installing omz plugin: $name"
    git clone "$repo" "$dest"
  fi
}
clone_omz_plugin zsh-direnv https://github.com/ptavares/zsh-direnv.git

# vim-plug for nvim
PLUG_VIM="$HOME/.local/share/nvim/site/autoload/plug.vim"
if [ ! -f "$PLUG_VIM" ]; then
  echo "installing vim-plug for nvim"
  curl -fLo "$PLUG_VIM" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  if command -v nvim >/dev/null 2>&1; then
    nvim --headless +PlugInstall +qall
  fi
fi

# legacy vim Vundle bootstrap
VIM_DIR="$HOME/.vim/bundle"
mkdir -p "$VIM_DIR"

VUNDLE_DIR="$VIM_DIR/Vundle.vim"
if ! [ -d $VUNDLE_DIR ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
	vim +PluginInstall +qall
fi
