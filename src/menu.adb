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
   begin
      case X is
         when 0 .. 60 =>
            return 5 - (Y / 60);
         when 61 .. 120 =>
            return 11 - (Y / 60);
         when 121 .. 180 =>
            return 17 - (Y / 60);
         when others =>
            return 23 - (Y / 60);
      end case;
   end;

   function Get_Rom_Index return Integer is
   begin
      loop
         declare
            State : constant TP_State := Touch_Panel.Get_All_Touch_Points;
            X : Integer := 0;
            Y : Integer := 0;
         begin
            case State'Length is
               when 0 =>
                  null;
               when others =>
                  for Id in State'Range loop
                     X := State(Id).X;
                     Y := State(Id).Y;
                     return Compute_Rom_Index(X, Y);
                  end loop;
            end case;
         end;
      end loop;
   end;

end;
