with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;

with Ada.Text_IO;           use Ada.Text_IO;
with Interfaces;            use Interfaces;
with Types;             use Types;

package Keyboard is
   Keyboard_Start : constant Integer := 160;
   Key_Size : constant Integer := 10;

   subtype Position is Integer range 0 ..320;

   subtype Key is Integer range -1 .. 15;

   -- scale of the keyboard is 4 pixels, size = 80 * 320
   type Keyboard_Buffer is array (0 .. 1599) of Boolean;
   pragma Pack(Keyboard_buffer);
   Line : constant Integer := 20;

   procedure Reset_Keyboard(Keyboard: in out Keyboard_Buffer);
   procedure Render_Keyboard(Keyboard: in Keyboard_Buffer);
   procedure Reset_Pressed_Keys(Pressed: in out Keys);
   procedure Get_Pressed_Key(Keyboard: in out Keyboard_Buffer;
                             Pressed: in out Keys;
                             Regs: in out GeneralRegs;
                             Blocked: in out Integer;
                             X: in Position; Y: in Position);
end Keyboard;
