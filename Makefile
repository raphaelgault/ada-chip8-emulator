PREFIX=arm-eabi
OBJCOPY=$(PREFIX)-objcopy
GDB=$(PREFIX)-gdb

ENTRY_POINT=prj.gpr
DEBUGDIR=objdebug
RELEASEDIR=objrelease
ELF=main
BIN=$(ELF).bin

release:
	gprbuild -P $(ENTRY_POINT) -Xmode=release
	$(OBJCOPY) -O binary $(RELEASEDIR)/$(ELF) $(BIN)

debug:
	gprbuild -P $(ENTRY_POINT) -Xmode=debug
	$(OBJCOPY) -O binary $(DEBUGDIR)/$(ELF) $(BIN)

prove:
	gnatprove -P $(ENTRY_POINT) -u src/handlers.ads

generate-roms:
	./tests/generate-roms.sh

flash:
	st-flash --reset write $(BIN) 0x08000000

gdb:
	$(GDB) $(DEBUGDIR)/$(ELF)

clean:
	gprclean -Xmode=release
	gprclean -Xmode=debug
	$(RM) src/rom.ads
	$(RM) $(BIN)
	$(RM) -rf $(DEBUGDIR) $(RELEASEDIR)
