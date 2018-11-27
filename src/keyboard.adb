package body Keyboard is
   procedure Write_Key(Keyboard : in out Keyboard_buffer;
                       Code : in Integer; Pos : in Integer)
   is
   begin
      for I in 0 .. 4 loop
         for J in 0 .. 3 loop
            Keyboard(Pos + (J * 20 ) + I) := True;
         end loop;
         -- Tmp := (Shift_Right(Tmp, 4));
      end loop;
   end;

   procedure Reset_Keyboard(Keyboard: in out Keyboard_buffer)
   is
      type Keys_Arr is array (0 .. 15) of Integer;
      -- Numbers from 0 to F
      Keys : constant Keys_Arr := (16#F999F#, 16#26227#, 16#F1F8F#, 16#F1F1F#,
                                   16#99F11#, 16#F8F1F#, 16#F8F9F#, 16#F1244#,
                                   16#F9F9F#, 16#F9F1F#, 16#F9F99#, 16#E9E9E#,
                                   16#F888F#, 16#E999E#, 16#F8F8F#, 16#F8F88#);
   begin
      for I in Keys'Range loop
         Write_Key(Keyboard, Keys(I),
                   20 * ((I / 2) * 10 + 3) + ((I mod 2) * 10) + 3);
      end loop;
   end;

   procedure Render_Keyboard(Keyboard: in Keyboard_Buffer)
   is
      Cur_pos : Point;
      Cur_Rect : Rect;
   begin
      for I in Keyboard'Range loop
         if Keyboard(I) = True then
            Cur_Pos := (Keyboard_Start + ((I mod Line) * 4), (I / Line) * 4);
            Cur_Rect := (Cur_Pos, 4, 4);
            Display.Hidden_Buffer(1).Fill_Rect(Cur_Rect);
         end if;
      end loop;
   end;

   function Get_Key(X : in Position; Y : in Position) return Key
   is
   begin
      return 0;
   end;
end;
