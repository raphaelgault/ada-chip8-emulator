PREFIX=arm-eabi
OBJCOPY=$(PREFIX)-objcopy

ENTRY_POINT=prj.gpr
ELF=obj/main
BIN=$(ELF).bin

all:
	gprbuild -P $(ENTRY_POINT)
	$(OBJCOPY) -O binary $(ELF) $(BIN)

flash:
	st-flash --reset write $(BIN) 0x08000000

clean:
	gprclean
