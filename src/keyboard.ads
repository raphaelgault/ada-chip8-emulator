with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;

with Ada.Text_IO;           use Ada.Text_IO;
with Interfaces;            use Interfaces;

package Keyboard is
   Keyboard_Start : constant Integer := 160;

   subtype Position is Integer range 0 ..320;

   -- 0 to F, handle multi press
   type Keys is array (0 .. 15) of Boolean;
   pragma Pack(Keys);

   -- scale of the keyboard is 4 pixels, size = 80 * 320
   type Keyboard_Buffer is array (0 .. 1599) of Boolean;
   pragma Pack(Keyboard_buffer);
   Line : constant Integer := 20;

   procedure Reset_Keyboard(Keyboard: in out Keyboard_Buffer);
   procedure Render_Keyboard(Keyboard: in Keyboard_Buffer);
   procedure Reset_Pressed_Keys(Pressed : in out Keys);
   procedure Get_Pressed_Key(Pressed : in out Keys;
                             X: in Position; Y: in Position);
end Keyboard;
