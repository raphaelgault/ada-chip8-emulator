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
      R := (Pt, Screen_Width, Screen_Height);
      Display.Hidden_Buffer(1).Draw_Rect(R);

      -- Compute Keyboard borders 80 * 320
      Pt := (0, Screen_Height);
      R := (Pt, Screen_Width, 240 - Screen_Height);
      Display.Hidden_Buffer(1).Draw_Rect(R);

      Pt := (0, 200);
      Display.Hidden_Buffer(1).Draw_Horizontal_Line(Pt, Screen_Width);

      for I in 1 .. 7 loop
         Pt := (I * 40, 160);
         Display.Hidden_Buffer(1).Draw_Vertical_Line(Pt, 80);
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
            Cur_Pos := ((I mod 64) * Pixel_Size, (I / 64) * Pixel_Size);
            Cur_Rect.Position := Cur_Pos;
            Display.Hidden_Buffer(2).Fill_Rect(Cur_Rect);
         end if;
      end loop;
   end;

   ----------------
   -- Draw_Pixel --
   ----------------

   procedure Draw_Pixel(Screen: in out Pixel_Buffer; I : Natural; Color : Boolean)
   is
      Cur_Pos : Point := (0, 0);
      Cur_Rect : Rect := (Cur_Pos, Pixel_Size, Pixel_Size);
      Pixel_Color : Bitmap_Color := Hal.Bitmap.White;
   begin
      if Color = False then
         Pixel_Color := Hal.Bitmap.Transparent;
      end if;
      Display.Hidden_Buffer(2).Set_Source(Pixel_Color);
      Cur_Pos := ((I mod 64) * Pixel_Size, (I / 64) * Pixel_Size);
      Cur_Rect.Position := Cur_Pos;
      Display.Hidden_Buffer(2).Fill_Rect(Cur_Rect);
   end;

end;
