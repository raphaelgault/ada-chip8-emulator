package body Class_Eight is

  --------
  -- LD --
  --------

  procedure LD (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.GeneralRegisters(X) := vm.GeneralRegisters(Y);
  end LD;

  --------------
  -- OR_instr --
  --------------

  procedure OR_instr (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) or vm.GeneralRegisters(Y);
  end OR_instr;

  ---------------
  -- AND_instr --
  ---------------

  procedure AND_instr (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) and vm.GeneralRegisters(Y);
  end AND_instr;

  ---------------
  -- XOR_instr --
  ---------------

  procedure XOR_instr (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) xor vm.GeneralRegisters(Y);
  end XOR_instr;

  ---------
  -- ADD --
  ---------

  procedure ADD (x : Integer; y : Integer; vm : in out Registers.Registers) is
    A : Types.Byte;
    B : Types.Byte;
  begin
    A := vm.GeneralRegisters(X);
    B := vm.GeneralRegisters(Y);
    vm.GeneralRegisters(X) := A + B;
    if Integer(A) + Integer(B) > 255 then
      vm.GeneralRegisters(15) := 1;
    else
      vm.GeneralRegisters(15) := 0;
    end if;
  end ADD;

  ---------
  -- SUB --
  ---------

  procedure SUB (x : Integer; y : Integer; vm : in out Registers.Registers) is
    A : Types.Byte;
    B : Types.Byte;
  begin
    A := vm.GeneralRegisters(X);
    B := vm.GeneralRegisters(Y);
    vm.GeneralRegisters(X) := A - B;
    if Integer(A) > Integer(B) then
      vm.GeneralRegisters(15) := 1;
    else
      vm.GeneralRegisters(15) := 0;
    end if;
  end SUB;

  ---------
  -- SHR --
  ---------

  procedure SHR (x : Integer; y : Integer; vm : in out Registers.Registers) is
  begin
    if (vm.GeneralRegisters(X) and 16#01#) /= 0 then
      vm.GeneralRegisters(15) := 1;
    else
      vm.GeneralRegisters(15) := 0;
    end if;
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) / 2;
  end SHR;

  ----------
  -- SUBN --
  ----------

  procedure SUBN (x : Integer; y : Integer; vm : in out Registers.Registers) is
    A : Types.Byte;
    B : Types.Byte;
  begin
    A := vm.GeneralRegisters(X);
    B := vm.GeneralRegisters(Y);
    vm.GeneralRegisters(X) := B - A;
    if Integer(B) > Integer(A) then
      vm.GeneralRegisters(15) := 1;
    else
      vm.GeneralRegisters(15) := 0;
    end if;
  end SUBN;

  ---------
  -- SHL --
  ---------

  procedure SHL (x : Integer; y : Integer; vm : in out Registers.Registers) is
  begin
    if (vm.GeneralRegisters(X) and 16#80#) /= 0 then
      vm.GeneralRegisters(15) := 1;
    else
      vm.GeneralRegisters(15) := 0;
    end if;
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) * 2;
  end SHL;

end Class_Eight;
