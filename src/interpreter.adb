with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Stack; use Stack;
with Types; use Types;
with Rom; use Rom;
with Handlers; use Handlers;
with Registers; use Registers;
with Interfaces; use Interfaces;

package body Interpreter is
  procedure Interprete
  is
     package Byte_IO is new Ada.Text_Io.Modular_IO (Types.Opcode);
     E : Integer;
     N : Opcode;
     I : Opcode;
     VM : Registers.Registers;
  begin

    loop
      N := mem(VM.PC);
      N := 
      I := N and 16#F000#;
      --Byte_IO.Put(Item => N, Base => 16);
      --Put(E'Image & " -> Class : ");
      I := rshift(N, 12);
      --Byte_IO.Put(Item => I, Base => 16);
      --Put_Line(" " & Integer(I)'Image & "");
      Handlers.Handler_Table(Integer(I)).all(Rom.instructions(E), VM);
    end loop;
  end Interprete;
end Interpreter;
