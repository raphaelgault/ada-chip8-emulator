package body Graphics is
   -- Find position in the screen according to index
   function Compute_Position(Index: Integer) return Point
   is
      Position : Point := (0, 0);
   begin
      Position := ((Index / 64) * Pixel_Size, abs(63  - (Index mod 64)) * Pixel_Size);
      return Position;
   end;

   -- Write the buffer
   procedure Draw_Screen(Screen : in out Pixel_Buffer)
   is
      Cur_Pos : Point := (0, 0);
      Cur_Rect : Rect := (Cur_Pos, Pixel_Size, Pixel_Size);
   begin
      for I in Screen'Range loop
         if Screen(I) = True then
            Cur_Pos := Compute_Position(I);
            Cur_Rect.Position := Cur_Pos;
            Display.Hidden_Buffer(1).Fill_Rect(Cur_Rect);
         end if;
      end loop;
   end;

   procedure Draw_Borders is
      Pt : Point := (0, 0);
      R : Rect;
   begin
      -- Compute borders
      R := (Pt, Screen_Height, Screen_Width);
      Display.Hidden_Buffer(1).Draw_Rect(R);

      -- Compute Keyboard borders 80 * 320
      Pt := (Screen_Height, 0);
      R := (Pt, 240 - (Screen_Height), Screen_Width);
      Display.Hidden_Buffer(1).Draw_Rect(R);

      Pt := (200, 0);
      Display.Hidden_Buffer(1).Draw_Vertical_Line(Pt, Screen_Width);

      for I in 0 .. 8 loop
         Pt := (160, I * 40);
         Display.Hidden_Buffer(1).Draw_Horizontal_Line(Pt, 80);
      end loop;

   end;

end;
