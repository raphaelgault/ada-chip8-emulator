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

## Debug

``` bash
st-util   # start gdb-server in another terminal
make gdb  # start gdb and connect to the gdb-server
```

Click [here](https://rawgit.com/alexanderdickson/Chip-8-Emulator/master/index.html) to compare with the original ROM behaviour.

## Working ROMs

* 15PUZZLE
* _CONNECT4_
* _GUESS_
* _HIDDEN_
* IBM
* INVADERS
* _KALEID_
* MAZE
* _MERLIN_
* _MISSILE_
* _PONG_
* _PONG2_
* _PUZZLE_
* _SYGYZY_
* _TICTAC_
* _UFO_
* _VBRIX_
* _WIPEOFF_

All ROMs in italic need an additional check with the keyboard.

## Not working ROMs

* BLITZ : Good display but keyboard not working : Maybe the wait for keyboard function?
* BLINKY : No display
* BRIX : Good beginning of display but weird game playing
* TANK : En fait je comprends pas ce que ça doit faire, ça fait des trucs différents
* TETRIS : Bonne grosse exception au runtime
* VERS : Bonne grosse exception au runtime

## Notes

Maybe we should increase the timer decrementation to make it faster.
