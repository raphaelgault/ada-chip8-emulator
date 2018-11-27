with Ada.Text_IO; use Ada.Text_IO;
with Types; use Types;
with Registers; use Registers;

package body Class_Eight is
  procedure LD (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("LD");
  end LD;

  procedure OR_instr (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("OR");
  end OR_instr;

  procedure AND_instr (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("AND");
  end AND_instr;

  procedure XOR_instr (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("XOR");
  end XOR_instr;

  procedure ADD (x : Integer; y : Integer; vm : in out Registers.Registers) is
  begin
    Put_Line ("ADD");
  end ADD;

  procedure SUB (x : Integer; y : Integer; vm : in out Registers.Registers) is
  begin
    Put_Line ("SUB");
  end SUB;

  procedure SHR (x : Integer; y : Integer; vm : in out Registers.Registers) is
  begin
    Put_Line ("SHR");
  end SHR;

  procedure SUBN (x : Integer; y : Integer; vm : in out Registers.Registers) is
  begin
    Put_Line ("SUBN");
  end SUBN;

  procedure SHL (x : Integer; y : Integer; vm : in out Registers.Registers) is
  begin
    Put_Line ("SHL");
  end SHL;
end Class_Eight;
