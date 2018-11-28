with Ada.Text_IO; use Ada.Text_IO;
with Types; use Types;
with Registers; use Registers;

package body Class_Eight is
  procedure LD (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.GeneralRegisters(X) := vm.GeneralRegisters(Y);
  end LD;

  procedure OR_instr (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) or vm.GeneralRegisters(Y);
  end OR_instr;

  procedure AND_instr (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) and vm.GeneralRegisters(Y);
  end AND_instr;

  procedure XOR_instr (x : Integer; y : Integer; vm : in out Registers.Registers)
  is
  begin
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) xor vm.GeneralRegisters(Y);
  end XOR_instr;

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

  procedure SHR (x : Integer; y : Integer; vm : in out Registers.Registers) is
  begin
    if (vm.GeneralRegisters(X) and 16#01#) /= 0 then
      vm.GeneralRegisters(15) := 1;
    else
      vm.GeneralRegisters(15) := 0;
    end if;
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) / 2;
  end SHR;

  procedure SUBN (x : Integer; y : Integer; vm : in out Registers.Registers) is
  begin
    SUB(x, y, vm);
    vm.GeneralRegisters(15) := not vm.GeneralRegisters(15);
  end SUBN;

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
