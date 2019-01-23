package body Menu is
   procedure Draw is
      Pt : Point := (0, 0);
      R : Rect;
      Buffer : Any_Bitmap_Buffer := Display.Hidden_Buffer (1);

      Case_Width : Integer := Buffer.Width / 4;
      Case_Height : Integer := Buffer.Height / 6;
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
   end;

   function Compute_Rom_Index(X: Integer; Y : Integer) return Integer is
      Pt : Point := (0, 0);
      R : Rect := (Pt, 60, 60);

      Width : Integer := Display.Hidden_Buffer (1).Width / 4;
      Height : Integer := Display.Hidden_Buffer (1).Height / 6;

      Round_Y : Integer := (Y / Height) * height;
   begin
      Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.White);
      case X is
         when 0 .. 60 =>
            R := ((0, Round_Y), Width, Height);
            Display.Hidden_Buffer (1).Fill_Rect(R);
            return 5 - (Y / 60);
         when 61 .. 120 =>
            R := ((60, Round_Y), Width, Height);
            Display.Hidden_Buffer (1).Fill_Rect(R);
            return 11 - (Y / 60);
         when 121 .. 180 =>
            R := ((120, Round_Y), Width, Height);
            Display.Hidden_Buffer (1).Fill_Rect(R);
            return 17 - (Y / 60);
         when others =>
            R := ((180, Round_Y), Width, Height);
            Display.Hidden_Buffer (1).Fill_Rect(R);
            return 23 - (Y / 60);
      end case;
   end;

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
