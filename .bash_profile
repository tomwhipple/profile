export ARCHFLAGS="-arch x86_64"

export ANDROID_SDK=/Users/twhipple/android-sdk-macosx
export ANDROID_NDK=/Users/twhipple/android-ndk-r8b
# export ANDROID_NDK=/Volumes/android/ndk

export PATH=/usr/local/bin:/usr/local/share/python:$ANDROID_NDK:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:/usr/local/mysql/bin:$PATH
# PATH=/usr/local/share/python:/usr/local/Cellar/python2.6/2.6.5/bin:$PATH
export PYTHONPATH="/usr/local/Cellar/python/2.7.3/:$PYTHONPATH:"
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
#export PYTHONPATH=:

source /usr/local/share/python/virtualenvwrapper.sh

export TM_RST2HTML=`which rst2html.py`

# export PATH=/usr/local/cuda/bin:$PATH
# export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH

if [ -f `brew --prefix`/etc/bash_completion ]; then
    source `brew --prefix`/etc/bash_completion
fi

source ~/bin/git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[00;33m\]\t\n\[\033[00;37m\]\u@\h\[\033[00m\]:\[\033[00;36m\]\W\[\033[00m\]\[\033[00;33m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '

set -o vi

eval "$(rbenv init -)"