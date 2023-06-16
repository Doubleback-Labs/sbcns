#!/usr/bin/env zsh

if [[ -z $SBCNS ]]; then
    cd $SBCNS
    git pull
    source $SBCNS/utils/re_source.sh
fi