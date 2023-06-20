#!/bin/sh

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
SBCNS_REWIRE_SEPERATOR=_
DOT=$SBCNS/dot
UTILS=$SBCNS/utils
CONF=$SBCNS/conf

DEBUG=false
MEMORIES=$CONF/memories.yaml
REWIRE=$CONF/rewire.yaml

if ! command -v yq &> /dev/null
then
    echo "yq could not be found"

    if [[ "$EUID" -ne 0 ]]
      then echo "Run again as root to install yq"
      exit
    fi

    echo "Installing yq..."
    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && chmod +x /usr/bin/yq
fi


if [[ $ARG1 == "debug" ]]; then
  DEBUG=true
fi

if [[ $DEBUG == true ]]; then
  echo "DEBUG IS SET. SCRIPT WILL PERFORM DRYRUN"
  echo "AUTO DETECTED PATH SBCNS PATH IS : ${SBCNS}"
fi

for memory in $(yq e '.memories[]' ${MEMORIES}); do
  REWIRE_ORIGFILE=$( yq e '.rewire[0]' ${REWIRE})
  REWIRE_OLDFILE=$( yq e '.rewire[1]' ${REWIRE})
  REWIRE_SBCNSFILE=$( yq e '.rewire[2]' ${REWIRE}) 

  ORIGFILE=$HOME/$(echo "${REWIRE_ORIGFILE/$SBCNS_REWIRE_SEPERATOR/"$memory"}")
  OLDFILE=$HOME/$(echo "${REWIRE_OLDFILE/$SBCNS_REWIRE_SEPERATOR/"$memory"}")
  SBCNSFILE=$DOT/$(echo "${REWIRE_SBCNSFILE/$SBCNS_REWIRE_SEPERATOR/"$memory"}")

  if [[ $DEBUG == true ]]; then
    echo "================================"
    echo "= REWIRE_ORIGFILE :  ${REWIRE_ORIGFILE}"
    echo "= REWIRE_OLDFILE :  ${REWIRE_OLDFILE}"
    echo "= REWIRE_SBCNSFILE :  ${REWIRE_SBCNSFILE}"
    echo "= REWIRE_SBCNSFILE :  ${ORIGFILE}"
    echo "= REWIRE_SBCNSFILE :  ${OLDFILE}"
    echo "= REWIRE_SBCNSFILE :  ${SBCNSFILE}"
  fi

  if [[ -L ${ORIGFILE} ]] && [[ -e ${ORIGFILE} ]]; then
    echo "${ORIGFILE} Already configured"
  else
    if [[ -e ${ORIGFILE} ]]; then
      if [[ $DEBUG == false ]]; then
        mv $ORIGFILE $OLDFILE
      fi
      echo "not linked. move orig to old"
    fi

    if [[ $DEBUG == false ]];then
      if [[ $ARG1 == "relink" ]]; then
        rm $ORIGFILE
      fi
      
      echo "Linking ${SBCNSFILE} to ${ORIGFILE}"

      ln -s -f ${SBCNSFILE} ${ORIGFILE}
    fi
  fi                
done

exit 0