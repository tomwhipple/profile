#!/usr/bin/env bash

# TODO: Figure out PROFILE_DIR dynamically
PROFILE_DIR="$HOME/profile"

ln -s "$PROFILE_DIR/profile" .profile
ln -s "$PROFILE_DIR/bash_profile" .bash_profile