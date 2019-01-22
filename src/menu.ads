with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;
with HAL.Framebuffer;            use HAL.Framebuffer;
with HAL.Touch_Panel;       use HAL.Touch_Panel;

with Graphics; use Graphics;

package Menu is
   procedure Draw;
   function Get_Rom_Index return Integer;
end Menu;
