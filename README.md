# ada-chip8-emulator

A simple chip-8 emulator for STM32F429-Discovery

## Compilation

To compile :
``` bash
make # release mode
make release # also release mode
make debug # debug mode
```

## Debug

``` bash
st-util # start gdb-server in another terminal
make gdb # start gdb and connect to the gdb-server
```
