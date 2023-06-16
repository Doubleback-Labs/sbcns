#!/usr/bin/env bash

ARG1=$1


#
# Set's a machine up to use a repo
#

SBCNS=$(dirname $(realpath $0))
DOT=$SBCNS/dot
UTILS=$SBCNS/utils

source mmrs.sh

for i in "${!MMRS[@]}"
do
  
  echo "========================================="
  
  IFS=' ' read -ra ADDR <<< "${MMRS[$i]}"

  echo "orig file: ${ADDR[0]}"
  echo "old file: ${ADDR[1]}"
  echo "sbcns file: ${ADDR[2]}"

  ORIGFILE=${ADDR[0]}
  OLDFILE=${ADDR[1]}
  SBCNSFILE=${ADDR[2]}

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