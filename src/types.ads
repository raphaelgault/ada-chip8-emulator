package Types is
  subtype Key is Integer range 0 .. 255;
  subtype Addr is Integer range 0 .. 4095;
  subtype Integer_16 is Integer range -32768 .. 32767;
  subtype Unsigned_Int_8 is Integer range 0 .. 255;
  type GeneralRegs is array (Integer) of Integer_16;
  type RAM is array (Addr) of Integer_16;
end Types;
