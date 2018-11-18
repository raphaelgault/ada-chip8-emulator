PREFIX=arm-eabi
OBJCOPY=$(PREFIX)-objcopy

ENTRY_POINT=prj.gpr
ELF=obj/main
BIN=$(ELF).bin

all:
	gprbuild -P $(ENTRY_POINT)
	$(OBJCOPY) -O binary $(ELF) $(BIN)

generate-rom:
	./generate-rom.sh $(shell xxd -p ${ROM})

flash:
	st-flash --reset write $(BIN) 0x08000000

clean:
	gprclean
	rm src/rom.ads
