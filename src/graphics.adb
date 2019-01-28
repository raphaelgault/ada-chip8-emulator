package body Graphics is

   -----------------
   -- Init_Screen --
   -----------------

   procedure Init_Screen
   is
   begin
      --  Initialize LCD
      Display.Initialize;
      Display.Initialize_Layer (1, ARGB_8888);
      Display.Initialize_Layer (2, ARGB_8888);

      Display.Set_Orientation(Landscape);

      --  Initialize touch panel
      Touch_Panel.Initialize(Landscape);

      --  Initialize button
      User_Button.Initialize;

      LCD_Std_Out.Set_Font (BMP_Fonts.Font8x8);
      LCD_Std_Out.Current_Background_Color := HAL.Bitmap.Black;

      --  Clear LCD (set background)
      LCD_Std_Out.Clear_Screen;
   end;

   ------------------
   -- Draw_borders --
   ------------------

   procedure Draw_Borders
   is
      Pt : Point := (0, 0);
      R : Rect;
   begin
      Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.White);

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

   -----------------
   -- Reset_Layer --
   -----------------

   procedure Reset_Layer(Layer: Integer)
   is
   begin
      Display.Hidden_Buffer (Layer).Set_Source (HAL.Bitmap.Transparent);
      Display.Hidden_Buffer (Layer).Fill;

      Display.Hidden_Buffer (Layer).Set_Source (HAL.Bitmap.White);
   end;

   ----------------------
   -- Compute_Position --
   ----------------------

   -- Find position in the screen according to index
   function Compute_Position(Index: Integer) return Point
   is
      Position : Point := (0, 0);
   begin
      Position := ((Index / 64) * Pixel_Size, abs(63  - (Index mod 64)) * Pixel_Size);
      return Position;
   end;

   ------------------
   -- Clear_screen --
   ------------------

   procedure Clear_Screen(Screen : in out Pixel_Buffer)
   is
   begin
      Screen := (others => False);
   end;


   -------------------
   -- Render_screen --
   -------------------

   -- Write the buffer
   procedure Render_Screen(Screen: in out Pixel_Buffer)
   is
      Cur_Pos : Point := (0, 0);
      Cur_Rect : Rect := (Cur_Pos, Pixel_Size, Pixel_Size);
   begin
      for I in Screen'Range loop
         if Screen(I) = True then
            Cur_Pos := Compute_Position(I);
            Cur_Rect.Position := Cur_Pos;
            Display.Hidden_Buffer(2).Fill_Rect(Cur_Rect);
         end if;
      end loop;
   end;

end;
