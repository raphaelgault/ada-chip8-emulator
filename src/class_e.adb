with Ada.Text_IO; use Ada.Text_IO;
with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;

with Keyboard; use Keyboard;

package body Class_E is
  procedure SKP (x : in Integer; vm : in out Registers.Registers)
  is
    K : Integer := Integer(VM.GeneralRegisters(X));
  begin
     -- Put_Line ("SKP");
     if Vm.Pressed_Keys(K) = True then
        Vm.Pc := Vm.Pc + 2;
     end if;
  end SKP;

  procedure SKNP (x : in Integer; vm : in out Registers.Registers)
  is
    K : Integer := Integer(VM.GeneralRegisters(X));
  begin
     -- Put_Line ("SKNP");
     if Vm.Pressed_Keys(K) = False then
        Vm.Pc := Vm.Pc + 2;
     end if;
  end SKNP;

end Class_E;
