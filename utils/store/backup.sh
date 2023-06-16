#!/bin/sh 

if [[ -z $SBCNS ]]; then
    cd $SBCNS
    git add .
    git commit -m "$(date)"
    git push
    exit 0
fi

exit 1