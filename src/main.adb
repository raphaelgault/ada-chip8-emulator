------------------------------------------------------------------------------
--                                                                          --
--                     Copyright (C) 2015-2016, AdaCore                     --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
------------------------------------------------------------------------------

with Last_Chance_Handler;  pragma Unreferenced (Last_Chance_Handler);
--  The "last chance handler" is the user-defined routine that is called when
--  an exception is propagated. We need it in the executable, therefore it
--  must be somewhere in the closure of the context clauses.


with Ada.Text_IO; use Ada.Text_IO;

with Handlers; use Handlers;
with Graphics; use Graphics;
with Keyboard; use Keyboard;
with Registers; use Registers;
with Rom; use Rom;
with Types; use Types;

with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;
with HAL.Framebuffer;            use HAL.Framebuffer
                                   ;
pragma Warnings (Off, "referenced");
with HAL.Touch_Panel;       use HAL.Touch_Panel;
with STM32.User_Button;     use STM32;
with BMP_Fonts;
with LCD_Std_Out;

procedure Main
is
   BG : Bitmap_Color := (Alpha => 255, others => 0);

   Keyboard : Keyboard_Buffer := (others => False);
   Keyboard_Changed : Boolean := False;

   VM : Registers.Registers;

   N : Opcode;
   I : Opcode;

   DT : Byte;
begin
   --  Initialize LCD
   Display.Initialize;
   Display.Initialize_Layer (1, ARGB_8888);
   Display.Initialize_Layer (2, ARGB_8888);

   --  Initialize touch panel
   Touch_Panel.Initialize;

   --  Initialize button
   User_Button.Initialize;

   LCD_Std_Out.Set_Font (BMP_Fonts.Font8x8);
   LCD_Std_Out.Current_Background_Color := BG;

   --  Clear LCD (set background)
   LCD_Std_Out.Clear_Screen;

   Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Transparent);
   Display.Hidden_Buffer (1).Fill;

   Display.Hidden_Buffer (2).Set_Source (HAL.Bitmap.Transparent);
   Display.Hidden_Buffer (2).Fill;

   Display.Hidden_Buffer (2).Set_Source (HAL.Bitmap.White);

   Draw_Borders;

   -- Init keyboard
   Reset_Keyboard(Keyboard);
   Render_Keyboard(Keyboard);

   Display.Update_Layer (1, Copy_Back => True);

   load_rom;

   VM.PC := 512;
   loop
      if User_Button.Has_Been_Pressed then
         null;
         -- Will display the menu
      end if;

      if VM.Blocked = -1 then
         N := Opcode(lshift(Opcode(mem(VM.PC)), 8));
         N := N + Opcode(mem(VM.PC + 1));
         I := rshift(N, 12);
         Handlers.Handler_Table(Integer(I)).all(N, VM);
         VM.PC := VM.PC + 2;
      end if;

      if VM.DT /= 0 then
         DT := VM.DT - 1;
         if DT > 255 then
            VM.DT := 0;
         else
            VM.DT := VM.DT - 1;
         end if;
      end if;

      if Vm.Refresh_Screen = True then
         Display.Hidden_Buffer (2).Set_Source (HAL.Bitmap.Transparent);
         Display.Hidden_Buffer (2).Fill;

         Display.Hidden_Buffer (2).Set_Source (HAL.Bitmap.White);

         Render_Screen(VM.Screen);
         Display.Update_Layer (2, Copy_Back => False);
      end if;

      declare
         State : constant TP_State := Touch_Panel.Get_All_Touch_Points;
         Current_X : Integer := 0;
         Current_Y : Integer := 0;
      begin
         case State'Length is
            when 0 =>
               if Keyboard_Changed then
                  Reset_Pressed_Keys(VM.Pressed_Keys);
                  BG := HAL.Bitmap.Transparent;
                  Keyboard_Changed := False;
                  Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Transparent);
                  Display.Hidden_Buffer (1).Fill;
                  Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.White);
                  Draw_Borders;
                  Render_Keyboard(Keyboard);
                  Display.Update_Layer (1, Copy_Back => True);
               end if;
            when others =>
               for Id in State'Range loop
                  Current_X := State (Id).X;
                  Current_Y := State (Id).Y;
                  if Current_X >= Keyboard_Start then
                     Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.Transparent);
                     Display.Hidden_Buffer (1).Fill;
                     Display.Hidden_Buffer (1).Set_Source (HAL.Bitmap.White);
                     Draw_Borders;
                     Render_Keyboard(Keyboard);
                     Get_Pressed_Key(Keyboard, VM.Pressed_Keys,
                                     VM.GeneralRegisters, VM.Blocked,
                                     Current_X, Current_Y);
                     Display.Update_Layer (1, Copy_Back => False);
                     exit;
                  end if;
               end loop;
               Keyboard_Changed := True;
         end case;
      end;
      --  Update screen

   end loop;

end Main;
