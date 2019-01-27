package body Class_F is

  --------
  -- LD --
  --------

  procedure LD (i : Opcode ; x : Integer; vm : in out Registers.Registers)
  is
    B : Byte;
  begin
    B := Byte(i and 16#00FF#);
    case B is
       when 16#07# =>
         vm.GeneralRegisters(X) := vm.DT;
       when 16#0A# =>
         VM.Blocked := X;
       when 16#15# =>
         vm.DT := vm.GeneralRegisters(X);
       when 16#18# =>
         vm.ST := vm.GeneralRegisters(X);
       when 16#29# =>
         if Integer(vm.I) + Integer(vm.GeneralRegisters(X)) > 16#FFF# then
           Vm.GeneralRegisters (16#F#) := 1;
         else
           Vm.GeneralRegisters (16#F#) := 0;
         end if;
         vm.I := Integer(vm.GeneralRegisters(X)) * 5;
       when 16#33# =>
         mem(vm.I) := vm.GeneralRegisters(X) / 100;
         mem(vm.I + 1) := (vm.GeneralRegisters(X) / 10) mod 10;
         mem(vm.I + 2) := vm.GeneralRegisters(X) mod 10;
       when 16#55# =>
         for I in 0 .. X loop
           mem(vm.I + I) := vm.GeneralRegisters(I);
         end loop;
         vm.I := vm.I + X + 1;
       when 16#65# =>
         for I in 0 .. X loop
           vm.GeneralRegisters(I) := mem(vm.I + I);
         end loop;
         vm.I := vm.I + X + 1;
       when others =>
         null;
    end case;
  end LD;

  ---------
  -- ADD --
  ---------

  procedure ADD (x : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.I := vm.I + Addr(Vm.GeneralRegisters(X));
  end ADD;

end Class_F;
