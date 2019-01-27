package body Class_E is

  ---------
  -- SKP --
  ---------

  procedure SKP (x : in Integer; vm : in out Registers.Registers)
  is
    K : Integer := Integer(VM.GeneralRegisters(X));
  begin
    if Vm.Pressed_Keys(K) = True then
      Vm.Pc := Vm.Pc + 2;
    end if;
  end SKP;

  ----------
  -- SKNP --
  ----------

  procedure SKNP (x : in Integer; vm : in out Registers.Registers)
  is
    K : Integer := Integer(VM.GeneralRegisters(X));
  begin
    if Vm.Pressed_Keys(K) = False then
      Vm.Pc := Vm.Pc + 2;
    end if;
  end SKNP;

end Class_E;
