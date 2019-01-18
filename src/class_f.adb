with Ada.Text_IO; use Ada.Text_IO;
with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;
with Handlers; use Handlers;

package body Class_F is
  procedure LD (i : Opcode ; x : Integer; vm : in out Registers.Registers)
  is
    B : Byte;
    N : Integer;
  begin
    B := Byte(i and 16#00FF#);
    if B = 16#07# then
      vm.GeneralRegisters(X) := vm.DT;
    elsif B = 16#0A# then
      VM.GeneralRegisters(X) := Byte(Get_Pressed_Key(VM.Pressed_Keys));
    elsif B = 16#15# then
      vm.DT := vm.GeneralRegisters(X);
    elsif B = 16#18# then
      vm.ST := vm.GeneralRegisters(X);
    elsif B = 16#1E# then
      vm.I := vm.I + Addr(vm.GeneralRegisters(X));
    elsif B = 16#29# then
      --Put_Line ("LD F, Vx");
      vm.I := Integer(vm.GeneralRegisters(X)) * 5;
    elsif B = 16#33# then
      --Put_Line ("LD B, Vx");
      mem(vm.I) := vm.GeneralRegisters(X) / 100;
      mem(vm.I + 1) := (vm.GeneralRegisters(X) / 10) mod 10;
      mem(vm.I + 2) := vm.GeneralRegisters(X) mod 10;
    elsif B = 16#55# then
      --Put_Line ("LD [I], Vx");
      for I in 0 .. X loop
        mem(vm.I + I) := vm.GeneralRegisters(I);
      end loop;
    elsif B = 16#65# then
      --Put_Line ("LD Vx, [I]");
      for I in 0 .. X loop
         vm.GeneralRegisters(I) := mem(vm.I + I);
         -- TODO: check is add
      end loop;
    end if;
    -- need to differentiate the 8 different LD calls of this class;
  end LD;

  procedure ADD (x : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.I := vm.I + x;
  end ADD;
end Class_F;
