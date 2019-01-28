package body Keyboard is

   ---------------
   -- Write_Key --
   ---------------

   procedure Write_Key(Keyboard: in out Keyboard_buffer;
                       Code: in Integer; Pos: in Integer)
   is
      Line : Unsigned_64;
      Tmp : Unsigned_64;
   begin
      for I in 0 .. 4 loop
         Line := Shift_Right(Unsigned_64(Code), (4 - I) * 4) and 2#1111#;
         for J in 0 .. 3 loop
            Tmp := Shift_Right(Line, (3 - J)) and 1;
            if Tmp = 1 then
               Keyboard(Pos + (I * Line_Size) + J) := True;
            end if;
         end loop;
      end loop;
   end;


   --------------------
   -- Init_Keyboard --
   --------------------

   procedure Init_Keyboard(Keyboard: in out Keyboard_buffer)
   is
      type Keys_Arr is array (0 .. 15) of Integer;
      -- Code nbs, in order : 0, 8, 1, 9, 2, A, 3, B, 4, C, 5, D, 6, E, 7, F
      -- The number representation is 4x5 pixels where each 4 bits is
      -- equivalent to one line
      -- Order is different due to previous implementation
      Keys : constant Keys_Arr := (16#F999F#, 16#26227#, 16#F1F8F#, 16#F1F1F#,
                                   16#99F11#, 16#F8F1F#, 16#F8F9F#, 16#F1244#,
                                   16#F9F9F#, 16#F9F1F#, 16#F9F99#, 16#E9E9E#,
                                   16#F888F#, 16#E999E#, 16#F8F8F#, 16#F8F88#);
   begin
      for I in Keys'Range loop
         Write_Key(Keyboard, Keys(I),
                   Line_Size * ((I / 8) * 10 + 3) + ((I mod 8) * 10) + 3);
      end loop;
   end;

   ---------------------
   -- Render_Keyboard --
   ---------------------

   procedure Render_Keyboard(Keyboard: in Keyboard_Buffer)
   is
      Cur_pos : Point := (0, 0);
      Cur_Rect : Rect := (Cur_Pos, 4, 4);
   begin
      for I in Keyboard'Range loop
         if Keyboard(I) = True then
            Cur_Pos := ((I mod Line_Size) * 4, Keyboard_Start + (I / Line_Size) * 4);
            Cur_Rect.Position := Cur_Pos;
            Display.Hidden_Buffer(1).Fill_Rect(Cur_Rect);
         end if;
      end loop;
   end;

   ------------------------
   -- Reset_Pressed_Keys --
   ------------------------

   procedure Reset_Pressed_Keys(Pressed: in out Keys)
   is
   begin
      Pressed := (others => False);
   end;

   ----------------------------
   -- Update_Keyboard_Buffer --
   ----------------------------

   procedure Update_Keyboard_Buffer(Keyboard: in out Keyboard_Buffer;
                                    K : in Key)
   is
      Start_X : Natural := (K mod 8) * 10;
      Start_Y : Integer := 0;
      Cur_Index : Integer := 0;

      Cur_Pos : Point;
      Cur_Rect : Rect;
   begin
      if K >= 8 then
         Start_Y := 10;
      end if;
      for I in 0 .. Key_Size - 1 loop
         for J in 0 .. Key_Size - 1 loop
            Cur_Index := Start_X + I + (Start_Y + J) * Line_Size;

            if Keyboard(Cur_Index) = False then
               Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.White);
            else
               Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Black);
            end if;

            Cur_Pos := ((Cur_Index mod Line_Size) * 4,
                        Keyboard_Start + (Cur_Index / Line_Size) * 4);
            Cur_Rect := (Cur_Pos, 4, 4);
            Display.Hidden_Buffer(1).Fill_Rect(Cur_Rect);
         end loop;
      end loop;
   end;

   ---------------------
   -- Get_Pressed_Key --
   ---------------------

   procedure Get_Pressed_Key(Keyboard: in out Keyboard_Buffer;
                             Pressed: in out Keys;
                             Regs: in out GeneralRegs;
                             Blocked: in out Integer;
                             X: in Position; Y: in Position)
   is
      Bottom_Start : constant Integer := Keyboard_Start + 40;
      Current_Key : Key := -1;
   begin
      if Y >= Bottom_Start then
         Current_Key := 8 + (X / 40);
      elsif Y >= Keyboard_Start then
         Current_Key := (X / 40);
      end if;
      if Pressed(Current_Key) = False then
         Pressed(Current_Key) := True;
         if Blocked /= -1 then
           Regs(Blocked) := Byte(Current_Key);
           Blocked := -1;
         end if;
      end if;
      if Pressed(Current_Key) = True then
         Update_Keyboard_Buffer(Keyboard, Current_key);
      end if;
   end;
end;
