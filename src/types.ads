package Types is
  type Byte is mod 256 with Size => 8;
  type Opcode is mod 65536 with Size => 16;
  subtype Addr is Integer range 0 .. 4095;
  subtype Integer_16 is Integer range -32768 .. 32767;
  type GeneralRegs is array (0 .. 15) of Byte;
  pragma Pack(GeneralRegs);
  type RAM is array (Addr) of Integer_16;
  pragma Pack(RAM);
end Types;
