package body Interpreter is

  ----------------
  -- Interprete --
  ----------------

  procedure Interprete
  is
     package Byte_IO is new Ada.Text_Io.Modular_IO (Types.Opcode);
     E : Integer;
     N : Opcode;
     I : Opcode;
     VM : Registers.Registers;

     Dt : Byte;
  begin

     Load_Rom;
     VM.Pc := 512;

    loop
      if VM.Blocked = -1 then
         N := Opcode(lshift(Opcode(mem(VM.PC)), 8));
         N := N + Opcode(mem(VM.PC + 1));
         I := rshift(N, 12);

         Byte_Io.Put(Item => N, Base => 16);
         Put_Line("");

         Handlers.Handler_Table(Integer(I)).all(N, VM);
         VM.PC := VM.PC + 2;
      end if;

      if VM.DT /= 0 then
         DT := VM.DT - 1;
         -- Temporary : when the DT is substracted, it should be 0
         -- VM.DT is modular, we do not want is to go to the higher bound
         -- Solution : left it like this ou change Byte type.
         -- TODO: check value 259 in condition
         if DT > 255 then
            VM.DT := 0;
         else
            VM.DT := VM.DT - 1;
         end if;
      end if;
    end loop;
  end Interprete;

end Interpreter;
