
if [ -d "$HOME/android/sdk" ]; then
	export ANDROID_SDK="$HOME/android/sdk"
	export PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools	
elif [ -d "$HOME/android-sdk-macosx" ]; then
	export ANDROID_SDK=$HOME/android-sdk-macosx
	export PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools
fi

ANDROID_NDK=$HOME/android-ndk-r8e
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

PYTHON_VER=`python -c 'import sys; print "python{0}.{1}".format(sys.version_info[0],sys.version_info[1])'`
if [[ "$PYTHON_VER" != "" ]]; then
	export PYTHONPATH="/usr/local/lib/$PYTHON_VER/site-packages/:$PYTHONPATH"
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

TM_RST2HTML=`which rst2html.py`
if [ "$TM_RST2HTML" ]; then
	export TM_RST2HTML
fi

# export PATH=/usr/local/cuda/bin:$PATH
# export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH

if [ -f $LOCAL/etc/bash_completion ]; then
    source $LOCAL/etc/bash_completion
	
fi

source $HOME/profile/git-completion.bash

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[00;33m\]\t\n\[\033[00;37m\]\u@\h\[\033[00m\]:\[\033[00;36m\]\W\[\033[00m\]\[\033[00;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

set -o vi

if [ `which rbenv` ]; then
    eval "$(rbenv init -)"
fi
