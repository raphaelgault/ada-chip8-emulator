with Ada.Text_IO; use Ada.Text_IO;

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
  is
  begin
    Put_Line ("Class 1");
  end handler_1;

  procedure handler_2 (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class 2");
  end handler_2;

  procedure handler_3 (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class 3");
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
  begin
    Put_Line ("Class 8");
  end handler_8;

  procedure handler_9 (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class 9");
  end handler_9;

  procedure handler_A (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class A");
  end handler_A;

  procedure handler_B (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class B");
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
  begin
    Put_Line ("Class E");
  end handler_E;

  procedure handler_F (i : in Opcode; vm : in out Registers.Registers)
  is
  begin
    Put_Line ("Class F");
  end handler_F;
end Handlers;
