package body Menu is

   ----------
   -- Draw --
   ----------

   procedure Draw is
      Pt : Point := (0, 0);
      R : Rect;
      Buffer : Any_Bitmap_Buffer := Display.Hidden_Buffer (1);

      Case_Width : Integer := Buffer.Width / 4;
      Case_Height : Integer := Buffer.Height / 6;


      type Names is array (Integer range 0 .. 23) of access constant String;
      Rom_Names : Names := (Rom1'Access, Rom2'Access, Rom3'Access, Rom4'Access,
                            Rom5'Access, Rom6'Access, Rom7'Access, Rom8'Access,
                            Rom9'Access, Rom10'Access, Rom11'Access, Rom12'Access,
                            Rom13'Access, Rom14'Access, Rom15'Access, Rom16'Access,
                            Rom17'Access, Rom18'Access, Rom19'Access, Rom20'Access,
                            Rom21'Access, Rom22'Access, Rom23'Access, Rom24'Access);
   begin
      Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.White);

      -- Compute borders
      R := (Pt, Buffer.Width, Buffer.Height);
      Buffer.Draw_Rect(R);

      for I in 1 .. 3 loop
         Pt := (Case_Width * I, 0);
         Buffer.Draw_Vertical_Line(Pt, Buffer.Height);
      end loop;

      for I in 1 .. 5 loop
         Pt := (0, Case_Height * I);
         Buffer.Draw_Horizontal_Line(Pt, Buffer.Width);
      end loop;

      for I in Rom_Names'Range loop
         LCD_Std_Out.Put(10 + (I mod 4) * Case_Width,
                         15 + (I / 4) * Case_Height,
                         Rom_Names(I).all);
      end loop;

   end;

   -----------------------
   -- Compute_Rom_Index --
   -----------------------

   function Compute_Rom_Index(X: Integer; Y : Integer) return Integer is
      Pt : Point;
      R : Rect;

      Width : Integer := Display.Hidden_Buffer (1).Width / 4;
      Height : Integer := Display.Hidden_Buffer (1).Height / 6;

      Round_Y : Integer := (Y / Height) * Height;
   begin
      Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.White);
      case X is
         when 0 .. 80 =>
            R := ((0, Round_Y), Width, Height);
            Display.Hidden_Buffer (1).Fill_Rect(R);
            return 4 * (Y / Height);
         when 81 .. 160 =>
            R := ((80, Round_Y), Width, Height);
            Display.Hidden_Buffer (1).Fill_Rect(R);
            return 1 + 4 * (Y / Height);
         when 161 .. 240 =>
            R := ((160, Round_Y), Width, Height);
            Display.Hidden_Buffer (1).Fill_Rect(R);
            return 2 + 4 * (Y / Height);
         when others =>
            R := ((240, Round_Y), Width, Height);
            Display.Hidden_Buffer (1).Fill_Rect(R);
            return 3 + 4 * (Y / Height);
      end case;
   end;

   -------------------
   -- Get_Rom_Index --
   -------------------

   function Get_Rom_Index return Integer is
      Rom_Index : Integer := -1;
   begin
      loop
         declare
            State : constant TP_State := Touch_Panel.Get_All_Touch_Points;
            X : Integer := 0;
            Y : Integer := 0;
         begin
            case State'Length is
               when 0 =>
                  if Rom_Index /= -1 then
                     return Rom_Index;
                  end if;
               when others =>
                  if Rom_Index = -1 then
                     X := State (State'First).X;
                     Y := State (State'First).Y;
                     if X /= 0 or Y /= 0 then
                        Rom_Index := Compute_Rom_Index(X, Y);
                        Display.Update_Layer (1, Copy_Back => True);
                     end if;
                  end if;
            end case;
         end;
      end loop;
   end;

end;
