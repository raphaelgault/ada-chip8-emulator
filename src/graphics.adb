package body Graphics is
   function Init_Screen return Pos_Buffer is
      Positions : Pos_Buffer;
      Cur_pos : Point;
      Cur_Rect : Rect;
   begin
      for I in Positions'Range loop
         Cur_Pos := (I * Pixel_Size, 0);
         Cur_Rect := (Cur_Pos, Pixel_Size, Pixel_Size);
         Positions(I) := Cur_Rect;
      end loop;
      return Positions;
   end;

   procedure Draw_Screen(Screen : in out Pixel_Buffer;
                         Positions : in Pos_Buffer)
   is
   begin
      for I in Screen'Range loop
         if Screen(I) = True then
            Display.Hidden_Buffer(1).Draw_Rect(Positions(I));
         end if;
      end loop;
   end;
end;
