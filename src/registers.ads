with Types; use Types;

package Registers is
  type Registers is record
    GeneralRegisters : GeneralRegs range 0 .. 15;
    I : Addr; -- Address pointer
    VF : Unsigned_Int_8; -- Flag Register
    DT : Unsigned_Int_8; -- Timer
    PC : Integer_16;
    SP : Unsigned_Integer_8;
  end record;
end Registers;
