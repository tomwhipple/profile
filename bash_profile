
if [ -d "$HOME/android-sdk-macosx" ]; then
	export ANDROID_HOME=$HOME/android-sdk-macosx
	export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
fi

ANDROID_NDK=$HOME/android-ndk-r10d
if [ -d $ANDROID_NDK ]; then
	export ANDROID_NDK
	export PATH=$PATH:$ANDROID_NDK
fi

if [ `which brew` ]; then
	LOCAL=`brew --prefix`
	export PATH=$LOCAL/bin:$PATH
else
	LOCAL=/usr/local
fi

MYSQL_HOME=$LOCAL/mysql
if [ -d $MYSQL_HOME ]; then
	export PATH=$PATH:$MYSQL_HOME/bin
fi

PYTHON_VER=`python -c 'import sys; print("{0}.{1}".format(sys.version_info[0],sys.version_info[1]))'`
if [[ "$PYTHON_VER" != "" ]]; then
	if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
		# typical
		source /usr/local/bin/virtualenvwrapper.sh
	elif [ -f "/usr/local/share/python/virtualenvwrapper.sh" ]; then
		source /usr/local/share/python/virtualenvwrapper.sh
	fi
fi

GOHOME=$LOCAL/go
if [ -d "$GOHOME" ]; then
	export PATH="$GOHOME/bin:$PATH"
	export GOHOME

	GOPATH="$HOME/Documents/go"
	if [ -d "$GOPATH" ]; then
		export GOPATH
		export PATH="$PATH:$GOPATH/bin"
	fi
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

# export PATH=/usr/local/cuda/bin:$PATH
# export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH

if [ -f $LOCAL/etc/bash_completion ]; then
    source $LOCAL/etc/bash_completion
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

set -o vi

if [ `which rbenv` ]; then
    eval "$(rbenv init -)"
fi

if [ -f "$HOME/profile/tokens.private" ]; then
	source "$HOME/profile/tokens.private"
fi


### Added by the Heroku Toolbelt
if [ -d "/usr/local/heroku" ]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

ssh-agent && ssh-add
