#!/bin/sh

name=$1
shift

nb=0
instr=""
for i in $@; do
  l=${#i}
  j=0
  instr="$instr    " # >> src/rom.ads
  while [ $j -lt $l ]; do
    instr="${instr}16#${i:$j:4}#, " # >> src/rom.ads
    j=$((j + 4))
    nb=$((nb + 1))
  done;
  instr="$instr\n"
done;

echo "  $name: constant Code := (" >> src/rom.ads
printf "${instr::-4}" >> src/rom.ads

echo " );" >> src/rom.ads
