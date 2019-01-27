with BMP_Fonts;
with HAL.Bitmap;            use HAL.Bitmap;
with HAL.Framebuffer;            use HAL.Framebuffer;
with HAL.Touch_Panel;       use HAL.Touch_Panel;
with LCD_Std_Out;
with STM32.Board;           use STM32.Board;
with STM32.User_Button;     use STM32;

with Types; use Types;

package Graphics is
   -- Note: chip8 screen = 64 x 32 = 2048
   Pixel_Size : constant Integer := 5;
   Screen_Height : constant Integer := 32 * Pixel_Size;
   Screen_Width : constant Integer := 64 * Pixel_Size;

   procedure Init_Screen;

   procedure Draw_Borders;

   procedure Reset_Layer(Layer: Integer);

   procedure Render_Screen(Screen: in out Pixel_Buffer);

   procedure Clear_Screen(Screen : in out Pixel_Buffer);

end Graphics;
