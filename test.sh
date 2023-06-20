#!/usr/bin/env bash

d="HEY_"
m=" CAT"

ORIGFILE=$(echo "${d/_/"$m"}"); 


echo $ORIGFILE