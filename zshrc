# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Homebrew (Apple Silicon) — sets PATH/MANPATH/INFOPATH for /opt/homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ASDF v0.16+ configuration
if [ -d "$HOME/.asdf" ]; then
  export ASDF_DATA_DIR="$HOME/.asdf"
  export PATH="$ASDF_DATA_DIR/shims:$PATH"
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git virtualenv zsh-direnv)

source $ZSH/oh-my-zsh.sh

# User configuration

# Prepend hostname to the robbyrussell prompt
PROMPT="%{$fg[yellow]%}%m%{$reset_color%} ${PROMPT}"

# vim keybindings
bindkey -v

source ~/profile/aliases

# gnome-ssh-askpass is Linux-only; only export when present
if [ -x /usr/lib/openssh/gnome-ssh-askpass ]; then
  export SUDO_ASKPASS=/usr/lib/openssh/gnome-ssh-askpass
fi
