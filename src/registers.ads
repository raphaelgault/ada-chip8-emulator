with Stack; use Stack;
with Types; use Types;

package Registers is
  type Registers is record
    GeneralRegisters : GeneralRegs := (others => 0);
    I : Addr; -- Address pointer
    --VF : Unsigned_Int_8; -- Flag Register
    DT : Byte; -- Delay Timer
    ST : Byte; -- Sound Timer
    PC : Integer_16;
    SP : Byte;
    mem : RAM := (others => 0);
    stack : LifoStack := Stack_Init;
  end record;
end Registers;
