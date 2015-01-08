#!/usr/bin/env bash

REL_DIR=`dirname $0`
cd $REL_DIR

PROFILE_DIR=`pwd`
cd $HOME

echo 'exec /bin/bash -l' > .profile
ln -s "$PROFILE_DIR/bash_profile" .bash_profile