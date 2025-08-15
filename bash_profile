export BASH_SILENCE_DEPRECATION_WARNING=1

NVIM_PATH=`which nvim`
if [ -x "$NVIM_PATH" ]; then
  alias vim=nvim
else
  echo "nvim not installed"
fi

export EDITOR=vim
export VISUAL=$EDITOR

set -o vi


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


ssh-agent && ssh-add

if [ -d '/usr/local/opt/asdf/libexec/' ]; then
	. /usr/local/opt/asdf/libexec/asdf.sh
elif [ -d '/opt/homebrew/opt/asdf/libexec/' ]; then
	. /opt/homebrew/opt/asdf/libexec/asdf.sh
elif [ -d "$HOME/.asdf" ]; then
	. $HOME/.asdf/asdf.sh
	. $HOME/.asdf/completions/asdf.bash
fi

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/Users/tw/google-cloud-sdk/path.bash.inc' ]; then . '/Users/tw/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/Users/tw/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/tw/google-cloud-sdk/completion.bash.inc'; fi

export PATH="/Users/tw/.local/share/solana/install/active_release/bin:$PATH"


# Created by `pipx` on 2022-11-19 23:34:05
export PATH="$PATH:/Users/tw/.local/bin"
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
