
#########
# general
#########

# for OSX to stop nagging about zshell
export BASH_SILENCE_DEPRECATION_WARNING=1

# PATH modification moved to .bashrc to avoid duplication
# export PATH="$HOME/.local/bin:$PATH"

# ssh
if [ -z "$CLAUDECODE" ]; then
  ssh-agent
  ssh-add
fi


## bash & completion

if [ -f $LOCAL/etc/bash_completion ]; then
  source $LOCAL/etc/bash_completion
fi

if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


## nvim & editor
NVIM_PATH=`which nvim`
if [ -x "$NVIM_PATH" ]; then
  alias vim=nvim
else
  echo "nvim not installed"
fi

export EDITOR=vim
export VISUAL=$EDITOR



####
# git
####

if [[ `which brew` && -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]]; then
  GIT_PROMPT_THEME=Default
  source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
else
  # Probably somewhat out of date...
  source $HOME/profile/git-completion.bash

fi

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[00;33m\]\t\n\[\033[00;37m\]\u@\h\[\033[00m\]:\[\033[00;36m\]\W\[\033[00m\]\[\033[00;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '


