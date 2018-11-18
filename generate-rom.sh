#!/bin/sh

echo "with Types; use Types;" > src/rom.ads
echo "package Rom is" >> src/rom.ads
echo "  code: Opcode (" >> src/rom.ads

for i in $@; do
  l=${#i}
  j=0
  printf '    ' >> src/rom.ads
  while [ $j -lt $l ]; do
    printf '16#'${i:$j:4}', ' >> src/rom.ads
    j=$((j + 4))
  done;
  echo >> src/rom.ads
done;

echo "               )" >> src/rom.ads
echo "end Rom" >> src/rom.ads
