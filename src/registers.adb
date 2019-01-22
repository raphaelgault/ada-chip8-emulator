with Stack; use Stack;
with Types; use Types;
with Registers; use Registers;
with Rom; use Rom;
with Ada.Text_IO; use Ada.Text_IO;
with Interfaces; use Interfaces;

package body Registers is
  procedure dump_state(vm :Registers) is
  begin
    Put_Line ("============================================");
    Put_Line ("v0: " & Integer(vm.GeneralRegisters(0))'Image &
              " v1: " & Integer(vm.GeneralRegisters(1))'Image);
    Put_Line ("v2: " & Integer(vm.GeneralRegisters(2))'Image &
              " v3: " & Integer(vm.GeneralRegisters(3))'Image);
    Put_Line ("v4: " & Integer(vm.GeneralRegisters(4))'Image &
              " v5: " & Integer(vm.GeneralRegisters(5))'Image);
    Put_Line ("v6: " & Integer(vm.GeneralRegisters(6))'Image &
              " v7: " & Integer(vm.GeneralRegisters(7))'Image);
    Put_Line ("v8: " & Integer(vm.GeneralRegisters(8))'Image &
              " v9: " & Integer(vm.GeneralRegisters(9))'Image);
    Put_Line ("vA: " & Integer(vm.GeneralRegisters(10))'Image &
              " vB: " & Integer(vm.GeneralRegisters(11))'Image);
    Put_Line ("vC: " & Integer(vm.GeneralRegisters(12))'Image &
              " vD: " & Integer(vm.GeneralRegisters(13))'Image);
    Put_Line ("vE: " & Integer(vm.GeneralRegisters(14))'Image &
              " vF: " & Integer(vm.GeneralRegisters(15))'Image);
    Put_Line ("--------------------------------------------");
    Put_Line ("I: " & Integer(vm.I)'Image);
    Put_Line ("DT: " & Integer(vm.DT)'Image & " ST: " & Integer(vm.ST)'Image);
    Put_Line ("PC: " & Integer(vm.PC)'Image);
    Put_Line ("stack top : " & Integer(Stack_Top(vm.stack))'Image);
    Put_Line ("============================================");
  end dump_state;

  procedure load_rom (index: Integer) is
     N : Opcode;
     B : Unsigned_64;
     E : Opcode;
     J : Integer := 0;
     Instr: Code := Get_Rom_Code(index);
--type Code is array (Integer range <>) of Opcode;

  begin
     for I in Instr'Range loop
       --Put_Line ("Instruction #" & I'Image);
       N := Instr(I);
       B := Shift_Right(Unsigned_64(N), 8);
       E := N and 16#00FF#;
       mem(512 + 2 * J) := Byte(B);
       mem(512 + 2 * J + 1) := Byte(E);
       J := J + 1;
     end loop;
  end load_rom;

  function Get_Rom_Code (index: Integer) return Code is
  begin
       case index is
           when 0 => return ROM_15PUZZLE;
           when 1 => return ROM_BLINKY;
           when 2 => return ROM_BLITZ;
           when 3 => return ROM_BRIX;
           when 4 => return ROM_CONNECT4;
           when 5 => return ROM_GUESS;
           when 6 => return ROM_HIDDEN;
           when 7 => return ROM_IBM;
           when 8 => return ROM_INVADERS;
           when 9 => return ROM_KALEID;
           when 10 =>return ROM_MAZE;
           when 11 =>return ROM_MERLIN;
           when 12 =>return ROM_MISSILE;
           when 13 =>return ROM_PONG;
           when 14 =>return ROM_PONG2;
           when 15 =>return ROM_PUZZLE;
           when 16 =>return ROM_SYZYGY;
           when 17 =>return ROM_TANK;
           when 18 =>return ROM_TETRIS;
           when 19 =>return ROM_TICTAC;
           when 20 =>return ROM_UFO;
           when 21 =>return ROM_VBRIX;
           when 22 =>return ROM_VERS;
           when 23 =>return ROM_WIPEOFF;
           when others => return ROM_PONG;
       end case;
  end Get_Rom_Code;
end Registers;
