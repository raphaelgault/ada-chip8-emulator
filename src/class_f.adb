with Ada.Text_IO; use Ada.Text_IO;
with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;
with Handlers; use Handlers;

package body Class_F is
  procedure LD (i : Opcode ; x : Integer; vm : in out Registers.Registers)
  is
    B : Byte;
  begin
    B := Byte(i and 16#00FF#);
    if B = 16#07# then
      vm.GeneralRegisters(X) := vm.DT;
    elsif B = 16#0A# then
      Put_Line ("LD Vx, K");
    elsif B = 16#15# then
      vm.DT := vm.GeneralRegisters(X);
    elsif B = 16#18# then
      vm.ST := vm.GeneralRegisters(X);
    elsif B = 16#29# then
      Put_Line ("LD F, Vx");
    elsif B = 16#33# then
      Put_Line ("LD B, Vx");
    elsif B = 16#55# then
      Put_Line ("LD [I], Vx");
    elsif B = 16#65# then
      Put_Line ("LD [I], Vx");
    end if;
    -- need to differentiate the 8 different LD calls of this class;
  end LD;

  procedure ADD (x : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.I := vm.I + x;
  end ADD;
end Class_F;
