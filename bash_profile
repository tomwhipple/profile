export BASH_SILENCE_DEPRECATION_WARNING=1

NVIM_PATH=`which nvim`
if [ -x "$NVIM_PATH" ]; then
  alias vim nvim
else
  echo "nvim not installed"
fi

export EDITOR=vim
export VISUAL=$EDITOR

set -o vi

if [ -d $MYSQL_HOME ]; then
	export PATH=$PATH:$MYSQL_HOME/bin
fi

GOHOME=$LOCAL/go
if [ -d "$GOHOME" ]; then
   export PATH="$GOHOME/bin:$PATH"
   export GOHOME
fi

CUDA_HOME=/usr/local/cuda
if [ -d "$CUDA_HOME" ]; then
  export CUDA_HOME
  export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
  export PATH="$CUDA_HOME/bin:$PATH"
fi

TM_RST2HTML=`which rst2html.py`
if [ "$TM_RST2HTML" ]; then
        export TM_RST2HTML
fi

if [ -f $LOCAL/etc/bash_completion ]; then
  source $LOCAL/etc/bash_completion
fi

if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ `which brew` && -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]]; then
  GIT_PROMPT_THEME=Default
  source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
else
  # Probably somewhat out of date...
  source $HOME/profile/git-completion.bash

fi

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[00;33m\]\t\n\[\033[00;37m\]\u@\h\[\033[00m\]:\[\033[00;36m\]\W\[\033[00m\]\[\033[00;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

if [ `which rbenv` ]; then
    eval "$(rbenv init -)"
fi


### Added by the Heroku Toolbelt
if [ -d "/usr/local/heroku" ]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi


ssh-agent && ssh-add

if [ -d "$HOME/.asdf" ]; then
	source $HOME/.asdf/asdf.sh
	source $HOME/.asdf/completions/asdf.bash
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tw/google-cloud-sdk/path.bash.inc' ]; then . '/Users/tw/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tw/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/tw/google-cloud-sdk/completion.bash.inc'; fi

export PATH="/Users/tw/.local/share/solana/install/active_release/bin:$PATH"

