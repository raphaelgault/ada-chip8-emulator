with Ada.Numerics.Discrete_Random;
with Ada.Text_IO; use Ada.Text_IO;

with Class_E; use Class_E;
with Class_Eight; use Class_Eight;
with Class_F; use Class_F;
with Stack; use Stack;

with Graphics; use Graphics;

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
    A : Addr;
    K : Byte;
  begin
    K := Byte(i and 16#FF#);
    if K = 16#E0# then
      Put_Line ("CLS");
    elsif K = 16#EE# then
      vm.PC := Stack_Pop(vm.Stack);
    else
      A := Addr(i and 16#0FFF#);
      Put_Line ("SYS");
    end if;
  end handler_0;

  procedure handler_1 (i : in Opcode; vm : in out Registers.Registers)
  is -- JP addr
    N : Integer;
  begin
    N := Integer(i and 16#0FFF#);
    vm.PC := N;
  end handler_1;

  procedure handler_2 (i : in Opcode; vm : in out Registers.Registers)
  is
    N : Integer;
    B : Boolean;
  begin
    N := Integer(i and 16#0FFF#);
    B := Stack.Stack_Push(vm.Stack, vm.PC);
    if not B then
      Put_Line ("Error while pushing value of PC on the stack");
    end if;
    vm.PC := N;
  end handler_2;

  procedure handler_3 (i : in Opcode; vm : in out Registers.Registers)
  is
    X : Integer;
    K : Opcode;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    K := rshift(i and 16#00FF#, 8);
    if vm.GeneralRegisters(X) = Byte(K) then
      vm.PC := vm.PC + 1;
    end if;
  end handler_3;

  procedure handler_4 (i : in Opcode; vm : in out Registers.Registers)
  is
    X : Integer;
    K : Byte;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    K := Byte(i and 16#00FF#);
    if vm.GeneralRegisters(X) /= K then
      vm.PC := vm.PC + 1;
    end if;
  end handler_4;

  procedure handler_5 (i : in Opcode; vm : in out Registers.Registers)
  is -- SE Vx, Vy
    X : Integer;
    Y : Integer;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    Y := Integer(rshift(i and 16#00F0#, 4));
    if vm.GeneralRegisters(X) = vm.GeneralRegisters(Y) then
      vm.PC := vm.PC + 1;
    end if;
  end handler_5;

  procedure handler_6 (i : in Opcode; vm : in out Registers.Registers)
  is -- LD Vx, kk
    X : Integer;
    K : Byte;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    K := Byte(i and 16#FF#);
    vm.GeneralRegisters(X) := K;
  end handler_6;

  procedure handler_7 (i : in Opcode; vm : in out Registers.Registers)
  is -- ADD Vx, byte
    X : Integer;
    K : Opcode;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    K := i and 16#00FF#;
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) + Byte(K);
  end handler_7;

  procedure handler_8 (i : in Opcode; vm : in out Registers.Registers)
  is
    E : Integer;
    X : Integer;
    Y : Integer;
  begin
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
    vm.PC := N + Integer(vm.GeneralRegisters(0));
  end handler_B;

  procedure handler_C (i : in Opcode; vm : in out Registers.Registers)
  is
    package Random_Byte is new Ada.Numerics.Discrete_Random (Byte);
    use Random_Byte;
    G : Generator;
    X : Integer;
    B : Byte;
    K : Byte;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    Reset(G);
    K := Byte(i and 16#00FF#);
    B := Random(G);
    vm.GeneralRegisters(X) := K and B;
  end handler_C;

  -- TODO: Check function
  procedure handler_D (i : in Opcode; vm : in out Registers.Registers)
  is
     X : Integer;
     Y : Integer;
     Nibble : Integer;
     Line_Value : Opcode;
     Pixel : Opcode;
     Screen_Pos : Integer;
  begin
     X := Integer(Rshift(I and 16#0F00#, 8));
     X := Integer(Rshift(I and 16#0F00#, 4));
     Nibble := Integer(I and 16#000F#);

     for Line in 0 .. Nibble loop
        Line_Value := 0; -- Vm.Mem(Vm.I + Line);
        for Xpos in 0 .. 8 loop
           Pixel := Line_Value and Rshift(2#10000000#, Xpos);
           if Pixel /= 0 then
              Screen_Pos := X + Xpos + ((Y + Line) * 64);
              Vm.Screen(Screen_Pos) := Vm.Screen(Screen_Pos) xor True;
           end if;
        end loop;
     end loop;
  end handler_D;

  procedure handler_E (i : in Opcode; vm : in out Registers.Registers)
  is
    X : Integer;
    E : Integer;
  begin
    E := Integer(i and 16#00FF#);
    X := Integer(rshift(i and 16#0F00#, 4));

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
