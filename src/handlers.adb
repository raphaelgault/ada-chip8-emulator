with Ada.Text_IO; use Ada.Text_IO;
with Class_Eight; use Class_Eight;
with Class_E; use Class_E;
with Class_F; use Class_F;

package body Handlers is

  function rshift (val : opcode; num : Integer) return Opcode
  is
    v : Opcode := val;
  begin
    for I in 1 .. num loop
      v := v / 2;
    end loop;
    return v;
  end;

  procedure handler_0 (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class 0");
  end handler_0;

  procedure handler_1 (i : in Opcode; vm : in out Registers.Registers)
  is -- JP addr
    N : Integer;
  begin
    N := Integer(i and 16#0FFF#);
    vm.PC := N; -- Jump, need decrementing ?
  end handler_1;

  procedure handler_2 (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class 2");
  end handler_2;

  procedure handler_3 (i : in Opcode; vm : in out Registers.Registers)
  is
    X : Integer;
    K : Integer;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    K := Integer(rshift(i and 16#00FF#, 8));
    if Integer(vm.GeneralRegisters(X)) = K then
      vm.PC := vm.PC + 1;
    end if;
  end handler_3;

  procedure handler_4 (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class 4");
  end handler_4;

  procedure handler_5 (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class 5");
  end handler_5;

  procedure handler_6 (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class 6");
  end handler_6;

  procedure handler_7 (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class 7");
  end handler_7;

  procedure handler_8 (i : in Opcode; vm : in out Registers.Registers)
  is
    E : Integer;
    X : Integer;
    Y : Integer;
  begin
    Put_Line ("Class 8");
    E := Integer (i and 16#000F#);
    X := Integer (rshift(i and 16#0F00#, 8));
    Y := Integer (rshift(i and 16#00F0#, 4));

    if E < 8 then
      Class_Eight.Instr_Table(E).all(X, Y, vm);
    elsif E = 14 then
      Class_Eight.Instr_Table(8).all(X, Y, vm);
    else
      Put_Line ("Unknown Instruction with opcode " & Integer(I)'Image);
    end if;

  end handler_8;

  procedure handler_9 (i : in Opcode; vm : in out Registers.Registers)
  is -- 9xy0 - SNE Vx, Vy
    X : Integer;
    Y : Integer;
  begin
    X := Integer (rshift(i and 16#0F00#, 8));
    Y := Integer (rshift(i and 16#00F0#, 4));
    if X /= Y then
      vm.PC := vm.PC + 1; -- we skip next instruction;
    end if;
  end handler_9;

  procedure handler_A (i : in Opcode; vm : in out Registers.Registers)
  is
    N : Integer;
  begin
    N := Integer(i and 16#0FFF#);
    vm.I := N;
  end handler_A;

  procedure handler_B (i : in Opcode; vm : in out Registers.Registers)
  is -- JP V0, addr
    N : Integer;
  begin
    N := Integer(i and 16#0FFF#);
    vm.PC := N + Integer(vm.GeneralRegisters(0)); -- Jump, need decrementing ?
  end handler_B;

  procedure handler_C (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class C");
  end handler_C;

  procedure handler_D (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class D");
  end handler_D;

  procedure handler_E (i : in Opcode; vm : in out Registers.Registers)
  is
    package Byte_IO is new Ada.Text_Io.Modular_IO (Types.Opcode);
    X : Integer;
    E : Integer;
  begin
    E := Integer(i and 16#00FF#);
    X := Integer(rshift(i and 16#0F00#, 4));

    Put_Line ("E : " & E'Image);
    if E = 16#9E# then
      Class_E.SKP(X, vm);
    elsif E = 16#A1# then
      Class_E.SKNP(X, vm);
    else
      Put_Line ("Unknown Instruction with opcode " & E'Image & " - " & Integer(I)'Image);
    end if;

  end handler_E;

  procedure handler_F (i : in Opcode; vm : in out Registers.Registers)
  is
    X : Integer;
    E : Integer;
  begin
    E := Integer(i and 16#00FF#);
    X := Integer(rshift(i and 16#0F00#, 4));

    if E = 16#1E# then
      Class_F.ADD(X, vm);
    else
      Class_F.LD(i, X, vm);
    end if;
  end handler_F;
end Handlers;
