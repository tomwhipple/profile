#export ARCHFLAGS="-arch x86_64"

if [ -d "$HOME/android/sdk" ]; then
	export ANDROID_SDK="$HOME/android/sdk"
	export PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools	
elif [[ "$ANDROID_SDK" && -d "$HOME/$ANDROID_SDK" ]]; then
	export ANDROID_SDK=$HOME/android-sdk-macosx
	export PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools
fi

ANDROID_NDK=$HOME/android-ndk-r8b
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

# export PATH=/usr/local/bin:/usr/local/share/python:$ANDROID_NDK:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:/usr/local/mysql/bin:$PATH
# # PATH=/usr/local/share/python:/usr/local/Cellar/python2.6/2.6.5/bin:$PATH
# export PYTHONPATH="/usr/local/Cellar/python/2.7.3/:$PYTHONPATH:"
# export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
#export PYTHONPATH=:

PYSHARE=/usr/local/share/python
VIRTENVWRAP=$PYSHARE/virtualenvwrapper.sh
if [ -f "$VIRTENVWRAP" ]; then  
	# OSX/Brew
	source $VIRTENVWRAP
	export PATH=$PYSHARE:$PATH
elif [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
	# Raspian
	source /usr/local/bin/virtualenvwrapper.sh
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
