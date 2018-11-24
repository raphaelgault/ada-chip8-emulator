with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;

package Graphics is
   -- Note: chip8 screen = 64 x 32 = 2048
   Pixel_Size : constant Integer := 5;
   Screen_Height : constant Integer := 32 * Pixel_Size;
   Screen_Width : constant Integer := 64 * Pixel_Size;

   type Pixel_Buffer is array (0 .. 2047) of Boolean;
   -- type Pos_Buffer is array (0 .. 2047) of Integer range 0 .. 64;

   function Compute_Position(Index: Integer) return Point;

   procedure Draw_Screen(Screen : in out Pixel_Buffer);
   procedure Draw_Borders;
end Graphics;
