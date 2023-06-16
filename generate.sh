#!/usr/bin/env bash

# Author:  TJ Gillis <tj@doublebacklabs.com>
#
# Version 0.0.1
# Release Date 16/06/23 <dd/mm/yy>
#
# Contributors:
#   <This could be your name!>
#
# SPDX-License-Identifier: Unlicense

ARG1=$1


# 
# Set's a machine up to use a repo
#

SBCNS=$(dirname $(realpath $0))
DOT=$SBCNS/dot
UTILS=$SBCNS/utils

for mmr in $(yq -c --raw-output .mmrs[] mmrs.yaml); do
  REWIRE_ORIGFILE=$( yq -c --raw-output '.rewire[0]' rewire.yaml)
  REWIRE_OLDFILE=$( yq -c --raw-output '.rewire[1]' rewire.yaml)
  REWIRE_SBCNSFILE=$( yq -c --raw-output '.rewire[2]' rewire.yaml) 

  ORIGFILE=$HOME/$(echo "${REWIRE_ORIGFILE/_/"$mmr"}")
  OLDFILE=$HOME/$(echo "${REWIRE_OLDFILE/_/"$mmr"}")
  SBCNSFILE=$HOME/$(echo "${REWIRE_SBCNSFILE/_/"$mmr"}")


  echo $ORIGFILE

  if [[ -L ${ORIGFILE} ]] && [[ -e ${ORIGFILE} ]]; then
    echo "${ORIGFILE} Already configured"
  else
    if [[ -e ${ORIGFILE} ]]; then
      mv $ORIGFILE $OLDFILE
      echo "not linked. move orig to old"
    fi

    if [[ $ARG1 == "relink" ]]; then
      rm $ORIGFILE
    fi
    
    ln -s -f ${SBCNSFILE} ${ORIGFILE}
    echo "link to sbcns"
  fi                
done

exit 0