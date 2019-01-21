with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;

with Types; use Types;

package Graphics is
   -- Note: chip8 screen = 64 x 32 = 2048
   Pixel_Size : constant Integer := 5;
   Screen_Height : constant Integer := 32 * Pixel_Size;
   Screen_Width : constant Integer := 64 * Pixel_Size;

   procedure Clear_Screen(Screen : in out Pixel_Buffer);
   procedure Render_Screen(Screen: in out Pixel_Buffer);
   procedure Draw_Borders;
end Graphics;
