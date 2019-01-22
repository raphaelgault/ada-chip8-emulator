#!/bin/sh

echo "with Types; use Types;" > src/rom.ads
echo "package Rom is" >> src/rom.ads

echo "type Code is array (Integer range <>) of Opcode;" >> src/rom.ads

export GLOBIGNORE=tests/generate-roms.sh:tests/generate-rom.sh
for i in tests/*; do
  echo $i
  ./tests/generate-rom.sh ROM_${i#tests/} $(xxd -p $i)
done


echo "end Rom;" >> src/rom.ads
