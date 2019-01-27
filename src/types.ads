package Types is

  type Byte is mod 256 with Size => 8;

  type Opcode is mod 65536 with Size => 16;

  subtype Addr is Integer range 0 .. 4095;

  subtype Integer_16 is Integer -- range -32768 .. 32767;
    with Static_Predicate => Integer_16 >= -32768 and Integer_16 <= 32767;

  type GeneralRegs is array (0 .. 15) of Byte;
  pragma Pack(GeneralRegs);

  type RAM is array (Addr) of Byte;
  pragma Pack(RAM);

  type Pixel_Buffer is array (0 .. 2047) of Boolean;
  pragma Pack(Pixel_Buffer);

  type Keys is array (0 .. 15) of Boolean;
  pragma Pack(Keys);

end Types;
