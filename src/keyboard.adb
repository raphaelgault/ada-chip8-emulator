with Types; use Types;

package body Keyboard is
   procedure Write_Key(Keyboard: in out Keyboard_buffer;
                       Code: in Integer; Pos: in Integer)
   is
      Line : Unsigned_64;
      Tmp : Unsigned_64;
   begin
      for I in 0 .. 4 loop
         Line := Shift_Right(Unsigned_64(Code), (4 - I) * 4) and 2#1111#;
         for J in 0 .. 3 loop
            Tmp := Shift_Right(Line, J) and 1;
            if Tmp = 1 then
               Keyboard(Pos + (J * 20 ) + I) := True;
            end if;
         end loop;
      end loop;
   end;

   procedure Reset_Keyboard(Keyboard: in out Keyboard_buffer)
   is
      type Keys_Arr is array (0 .. 15) of Integer;
      -- Code nbs, in order : 7, F, 6, E, 5, D, 4, C, 3, B, 2, A, 1, 9, 0, 8
      -- The number representation is 4x5 pixels where each 4 bits is
      -- equivalent to one line
      Keys : constant Keys_Arr := (16#F1244#, 16#F8F88#, 16#F8F9F#, 16#F8F8F#,
                                   16#F8F1F#, 16#E999E#, 16#99F11#, 16#F888F#,
                                   16#F1F1F#, 16#E9E9E#, 16#F1F8F#, 16#F9F99#,
                                   16#26227#, 16#F9F1F#, 16#F999F#, 16#F9F9F#);
   begin
      Keyboard := (others => False);
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
            Display.Hidden_Buffer(2).Fill_Rect(Cur_Rect);
         end if;
      end loop;
   end;

   procedure Reset_Pressed_Keys(Pressed: in out Keys)
   is
   begin
      Pressed := (others => False);
   end;

   procedure Update_Keyboard_Buffer(Keyboard: in out Keyboard_Buffer;
                                    K : in Key)
   is
      Start_X : Natural := 0;
      Start_Y : Integer := (7 - K) * 10;
      Cur_Index : Integer := 0;
   begin
      if K >= 8 then
         Start_X := Start_X + 10;
         Start_Y := (7 - (K mod 8)) * 10;
      end if;
      for I in 0 .. Key_Size - 1 loop
         for J in 0 .. Key_Size - 1 loop
            Cur_Index := Start_X + I + ((Start_Y + J) * 20);
            Keyboard(Cur_Index) := not Keyboard(Cur_Index);
         end loop;
      end loop;
   end;

   procedure Get_Pressed_Key(Keyboard: in out Keyboard_Buffer;
                             Pressed: in out Keys;
                             Regs: in out GeneralRegs;
                             Blocked: in out Integer;
                             X: in Position; Y: in Position)
   is
      Bottom_Start : constant Integer := Keyboard_Start + 40;
      Current_Key : Key := -1;
   begin
      if X >= Bottom_Start then
         Current_Key := 15 - (Y / 40);
      elsif X >= Keyboard_Start then
         Current_Key := 7 - (Y / 40);
      end if;
      if Pressed(Current_Key) = False then
         Pressed(Current_Key) := True;
         if Blocked /= -1 then
           Regs(Blocked) := Byte(Current_Key);
           Blocked := -1;
         end if;
         Update_Keyboard_Buffer(Keyboard, Current_key);
      end if;
   end;
end;
