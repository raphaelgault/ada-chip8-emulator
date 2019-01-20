#!/bin/sh

echo "with Types; use Types;" > src/rom.ads
echo "package Rom is" >> src/rom.ads

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

echo "type Code is array (0 .. $((nb - 1))) of Opcode;" >> src/rom.ads
echo "  instructions: Code := (" >> src/rom.ads
printf "${instr::-4}" >> src/rom.ads

echo " );" >> src/rom.ads
echo "end Rom;" >> src/rom.ads
