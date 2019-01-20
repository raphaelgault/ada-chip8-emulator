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

  procedure load_rom is
     N : Opcode;
     B : Unsigned_64;
     E : Opcode;
  begin
     for I in instructions'Range loop
       --Put_Line ("Instruction #" & I'Image);
       N := instructions(I);
       B := Shift_Right(Unsigned_64(N), 8);
       E := N and 16#00FF#;
       mem(512 + 2 * Integer(I)) := Byte(B);
       mem(512 + 2 * Integer(I) + 1) := Byte(E);
     end loop;
  end load_rom;
  
--  function Get_Pressed_Key(keyboard: Keys) return Integer
--  is
--  begin
--    loop
--      for I in keyboard'Range loop
--        if keyboard(I) then
--          return I;
--        end if;
--      end loop;
--    end loop;
--  end Get_Pressed_Key;
end Registers;
