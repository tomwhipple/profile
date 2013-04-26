export ARCHFLAGS="-arch x86_64"

ANDROID_SDK=$HOME/android-sdk-macosx
if [ -d $ANDROID_SDK ]; then
	export ANDROID_SDK
	export PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools
fi

ANDROID_NDK=$HOME/android-ndk-r8b
if [ -d $ANDROID_NDK ]; then
	export ANDROID_NDK
	export PATH=$PATH:$ANDROID_NDK
fi

BREW_USR=`brew --prefix`

export PATH=$BREW_USR/bin:$PATH

MYSQL_HOME=$BREW_USR/mysql
if [ -d $MYSQL_HOME ]; then
	export PATH=$PATH:$MYSQL_HOME/bin
fi

# export PATH=/usr/local/bin:/usr/local/share/python:$ANDROID_NDK:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:/usr/local/mysql/bin:$PATH
# # PATH=/usr/local/share/python:/usr/local/Cellar/python2.6/2.6.5/bin:$PATH
# export PYTHONPATH="/usr/local/Cellar/python/2.7.3/:$PYTHONPATH:"
# export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
#export PYTHONPATH=:

VIRTENVWRAP=/usr/local/share/python/virtualenvwrapper.sh
if [ -f "VIRTENVWRAP" ]; then  
	source /usr/local/share/python/virtualenvwrapper.sh
fi

export TM_RST2HTML=`which rst2html.py`

# export PATH=/usr/local/cuda/bin:$PATH
# export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH

if [ -f $BREW_USR/etc/bash_completion ]; then
    source $BREW_USR/etc/bash_completion
	
fi

source $HOME/profile/git-completion.bash

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[00;33m\]\t\n\[\033[00;37m\]\u@\h\[\033[00m\]:\[\033[00;36m\]\W\[\033[00m\]\[\033[00;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

set -o vi

eval "$(rbenv init -)"