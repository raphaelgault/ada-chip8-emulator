with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;

package Graphics is
   -- Note: screen = 64 x 32 = 2048
   Pixel_Size : constant Integer := 5;
   type Pixel_Buffer is array (0 .. 2047) of Boolean;

   function Compute_Position(Index: Integer) return Point;
   procedure Draw_Screen(Screen : in out Pixel_Buffer);
end Graphics;
