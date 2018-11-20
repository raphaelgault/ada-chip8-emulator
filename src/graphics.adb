package body Graphics is
   -- Find position in the screen according to index
   function Compute_Position(Index: Integer) return Point is
      Position : Point := (0, 0);
   begin
      Position := ((Index / 64) * Pixel_Size, abs(63  - (Index mod 64)) * Pixel_Size);
      return Position;
   end;

   -- Write the buffer
   procedure Draw_Screen(Screen : in out Pixel_Buffer)
   is
      Cur_Pos : Point;
      Cur_Rect : Rect;
   begin
      for I in Screen'Range loop
         if Screen(I) = True then
            Cur_Pos := Compute_Position(I);
            Cur_Rect := (Cur_Pos, Pixel_Size, Pixel_Size);
            Display.Hidden_Buffer(1).Fill_Rect(Cur_Rect);
         end if;
      end loop;
   end;
end;
