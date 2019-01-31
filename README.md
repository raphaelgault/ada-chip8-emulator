# ada-chip8-emulator

A simple chip-8 emulator for STM32F429-Discovery

## Requirements

* A STM32F429-Discovery
* The package `st-link`
* This [toolchain](http://mirrors.cdn.adacore.com/art/5b0c1227a3f5d7097625478d)
* This [Ada Drivers Library](https://github.com/AdaCore/Ada_Drivers_Library) (to clone)
* Export these two paths (in your `.bashrc` or a script that will be sourced each time there is a need to compile) :
```bash
export PATH=/path/to/GNAT/toolchain/install/path/bin:$PATH
export GPR_PROJECT_PATH=/path/to/Ada_Drivers_Library
```

## Compilation

To compile :
``` bash
make          # release mode
make release  # also release mode
make debug    # debug mode
```

*Note*: if the command `make` is not used, the following script should be run to generate all the ROMs.
```bash
./tests/generate-roms
```

## Debug

``` bash
st-util   # start gdb-server in another terminal
make gdb  # start gdb and connect to the gdb-server
```

Click [here](https://rawgit.com/alexanderdickson/Chip-8-Emulator/master/index.html) to compare with the original ROM behaviour.

## Flash

``` bash
make flash
```

## ROMs list

* 15PUZZLE
* BLITZ
* BLINK
* BRIX
* CONNECT4
* GUESS
* HIDDEN
* IBM
* INVADERS
* KALEID
* MAZE
* MERLIN
* MISSILE
* PONG
* PONG2
* PUZZLE
* SYGYZY
* TANK
* TETRIS
* TICTAC
* UFO
* VBRIX
* VERS
* WIPEOFF

## AUTHORS

Raphaël Gault - <gault_r@epita.fr>
Tifanny Suyavong - <suyavo_t@epita.fr>
Guillaume Taquet Gaspérini - <taquet_g@epita.fr>
Grégoire Verdier - <verdie_g@epita.fr>
