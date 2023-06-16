#!/usr/bin/env bash

#
# Set's a machine up to use a repo
#

source generate.sh

SBCNS=$(basename $0)
DOT=$($SBCNS/dot)
UTILS=$($SBCNS/utils)

source mmrs.sh

for i in "${!MMRS[@]}"
do
  
  echo "========================================="

	IFS=' ' read -ra ADDR <<< "${MMRS[$i]}}"

  echo "orig file: ${ADDR[0]}"
  echo "old file: ${ADDR[1]}"
  echo "sbcns file: ${ADDR[2]}"

  ORIG=${ADDR[0]}

  if [[ -L ${ORIG} ]] && [[ -e ${ORIG} ]]; then
    echo "${ORIG} Already configured"
  else
    if [[ -e ${ORIG} ]]; then
      #mv $ADDR[0] $ADDR[1]
      echo "not linked. move orig to old"
    else
      #ln -s $ADDR[2] $ADDR[0]
      echo "link to sbcns"
    fi
  fi
  
done