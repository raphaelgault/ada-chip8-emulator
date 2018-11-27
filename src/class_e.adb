with Ada.Text_IO; use Ada.Text_IO;
with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;

package body Class_E is
  procedure SKP (x : Integer; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("SKP");
  end SKP;

  procedure SKNP (x : Integer; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("SKP");
  end SKNP;

end Class_E;
