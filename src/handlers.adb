package body Handlers is

  ------------
  -- rshift --
  ------------

  function rshift (val : opcode; num : Integer) return Opcode
  is
    v : Opcode := val;
  begin
    for I in 1 .. num loop
      v := v / 2;
    end loop;
    return v;
  end;

  ------------
  -- lshift --
  ------------

  function lshift (val : opcode; num : Integer) return Opcode
  is
    v : Opcode := val;
  begin
    for I in 1 .. num loop
      v := v * 2;
    end loop;
    return v;
  end;

  ---------------
  -- Handler_0 --
  ---------------

  procedure Handler_0 (i : in Opcode; vm : in out Registers.Registers)
  is
    A : Addr;
    K : Byte;
  begin
    K := Byte(i and 16#FF#);
    if K = 16#E0# then
      -- Clear the display
      VM.Screen := (others => false);
      Vm.Refresh_Screen := True;
    elsif K = 16#EE# then
      -- Return from subroutine
      vm.PC := Stack_Pop(vm.Stack);
    else
      -- Jump to addr - Ignored by interpreter?
      A := Addr(i and 16#0FFF#);
      null;
    end if;
  end Handler_0;

  ---------------
  -- Handler_1 --
  ---------------

  procedure Handler_1 (i : in Opcode; vm : in out Registers.Registers)
  is -- JP addr
    N : Integer;
  begin
    N := Integer(i and 16#0FFF#);
    vm.PC := N - 2;
  end Handler_1;

  ---------------
  -- Handler_2 --
  ---------------

  procedure Handler_2 (i : in Opcode; vm : in out Registers.Registers)
  is
    N : Integer;
    B : Boolean;
  begin
    N := Integer(i and 16#0FFF#);
    B := Stack.Stack_Push(vm.Stack, vm.PC);
    vm.PC := N - 2;
  end Handler_2;

  ---------------
  -- Handler_4 --
  ---------------

  procedure Handler_3 (i : in Opcode; vm : in out Registers.Registers)
  is
    X : Integer;
    K : Opcode;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    K := i and 16#00FF#;
    if vm.GeneralRegisters(X) = Byte(K) then
      vm.PC := vm.PC + 2;
    end if;
  end Handler_3;

  ---------------
  -- Handler_4 --
  ---------------

  procedure Handler_4 (i : in Opcode; vm : in out Registers.Registers)
  is
    X : Integer;
    K : Byte;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    K := Byte(i and 16#00FF#);
    if vm.GeneralRegisters(X) /= K then
      vm.PC := vm.PC + 2;
    end if;
  end Handler_4;

  ---------------
  -- Handler_5 --
  ---------------

  procedure Handler_5 (i : in Opcode; vm : in out Registers.Registers)
  is -- SE Vx, Vy
    X : Integer;
    Y : Integer;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    Y := Integer(rshift(i and 16#00F0#, 4));
    if vm.GeneralRegisters(X) = vm.GeneralRegisters(Y) then
      vm.PC := vm.PC + 2;
    end if;
  end Handler_5;

  ---------------
  -- Handler_6 --
  ---------------

  procedure Handler_6 (i : in Opcode; vm : in out Registers.Registers)
  is -- LD Vx, kk
    X : Integer;
    K : Byte;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    K := Byte(i and 16#FF#);
    vm.GeneralRegisters(X) := K;
  end Handler_6;

  ---------------
  -- Handler_7 --
  ---------------

  procedure Handler_7 (i : in Opcode; vm : in out Registers.Registers)
  is -- ADD Vx, byte
    X : Integer;
    K : Opcode;
  begin
    X := Integer(rshift(i and 16#0F00#, 8));
    K := i and 16#00FF#;
    vm.GeneralRegisters(X) := vm.GeneralRegisters(X) + Byte(K);
  end Handler_7;

  ---------------
  -- Handler_8 --
  ---------------

  procedure Handler_8 (i : in Opcode; vm : in out Registers.Registers)
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
    end if;
  end Handler_8;

  ---------------
  -- Handler_9 --
  ---------------

  procedure Handler_9 (i : in Opcode; vm : in out Registers.Registers)
  is -- 9xy0 - SNE Vx, Vy
    X : Integer;
    Y : Integer;
  begin
    X := Integer (rshift(i and 16#0F00#, 8));
    Y := Integer (rshift(i and 16#00F0#, 4));
    if vm.GeneralRegisters(X) /= vm.GeneralRegisters(Y) then
      vm.PC := vm.PC + 2; -- we skip next instruction;
    end if;
  end Handler_9;

  ---------------
  -- Handler_A --
  ---------------

  procedure Handler_A (i : in Opcode; vm : in out Registers.Registers)
  is
    N : Integer;
  begin
    N := Integer(i and 16#0FFF#);
    vm.I := N;
  end Handler_A;

  ---------------
  -- Handler_B --
  ---------------

  procedure Handler_B (i : in Opcode; vm : in out Registers.Registers)
  is -- JP V0, addr
    N : Integer;
  begin
    N := Integer(i and 16#0FFF#);
    vm.PC := N + Integer(vm.GeneralRegisters(0) - 2);
  end Handler_B;

  ---------------
  -- Handler_C --
  ---------------

  procedure Handler_C (i : in Opcode; vm : in out Registers.Registers)
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
  end Handler_C;

  ---------------
  -- Handler_D --
  ---------------

  procedure Handler_D (i : in Opcode; vm : in out Registers.Registers)
  is
    X : Integer;
    Y : Integer;
    Nibble : Integer;
    Line_Value : Byte;
    Pixel : Opcode;
    Screen_Pos : Integer;

  begin
    X := Integer(VM.GeneralRegisters(Integer(Rshift(I and 16#0F00#, 8))));
    Y := Integer(VM.GeneralRegisters(Integer(Rshift(I and 16#00F0#, 4))));
    Nibble := Integer(I and 16#000F#);

    Vm.GeneralRegisters(15) := 0;

    for Line in 0 .. Nibble - 1 loop
      Line_Value := Mem(Vm.I + Line);
      for Xpos in 0 .. 7 loop
        Pixel := Opcode(Line_Value) and Rshift(2#10000000#, Xpos);
        if Pixel /= 0 then
          Screen_Pos := ((X + Xpos) mod 64) + ((Y + Line) mod 32) * 64;
          Vm.Screen(Screen_Pos) := Vm.Screen(Screen_Pos) xor True;
          if Vm.Screen(Screen_Pos) = False then
            Vm.GeneralRegisters(15) := 1;
          end if;
        end if;
      end loop;
    end loop;

    Vm.Refresh_Screen := True;
  end Handler_D;

  ---------------
  -- Handler_E --
  ---------------

  procedure Handler_E (i : in Opcode; vm : in out Registers.Registers)
  is
    X : Integer;
    E : Integer;
  begin
    E := Integer(i and 16#00FF#);
    X := Integer(rshift(i and 16#0F00#, 8));

    if E = 16#9E# then
      Class_E.SKP(X, vm);
    elsif E = 16#A1# then
      Class_E.SKNP(X, vm);
    end if;
  end Handler_E;

  ---------------
  -- Handler_F --
  ---------------

  procedure Handler_F (i : in Opcode; vm : in out Registers.Registers)
  is
    X : Integer;
    E : Integer;
  begin
    E := Integer(i and 16#00FF#);
    X := Integer(rshift(i and 16#0F00#, 8));

    if E = 16#1E# then
      Class_F.ADD(X, vm);
    else
      Class_F.LD(i, X, vm);
    end if;
  end Handler_F;

end Handlers;
