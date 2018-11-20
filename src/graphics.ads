with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;

package Graphics is
   -- Note: screen = 64 x 32 = 2048
   Pixel_Size : constant Integer := 10;
   type Pixel_Buffer is array (1 .. 2048) of Boolean;
   type Pos_Buffer is array (1 .. 2048) of Rect;

   function Init_Screen return Pos_Buffer;
   procedure Draw_Screen(Screen : in out Pixel_Buffer;
                         Positions : in Pos_Buffer);
end Graphics;
