with STM32.Board;           use STM32.Board;
with HAL.Bitmap;            use HAL.Bitmap;
with HAL.Framebuffer;            use HAL.Framebuffer;
with HAL.Touch_Panel;       use HAL.Touch_Panel;
with LCD_Std_Out;

with Graphics; use Graphics;

package Menu is

   Rom1 : aliased constant String := "15PUZZLE";
   Rom2 : aliased constant String := "BLINKY";
   Rom3 : aliased constant String := "BLITZ";
   Rom4 : aliased constant String := "BRIX";
   Rom5 : aliased constant String := "CONNECT4";
   Rom6 : aliased constant String := "GUESS";
   Rom7 : aliased constant String := "HIDDEN";
   Rom8 : aliased constant String := "IBM";
   Rom9 : aliased constant String := "INVADERS";
   Rom10 : aliased constant String := "KALEID";
   Rom11 : aliased constant String := "MAZE";
   Rom12 : aliased constant String := "MERLIN";
   Rom13 : aliased constant String := "MISSILE";
   Rom14 : aliased constant String := "PONG";
   Rom15 : aliased constant String := "PONG2";
   Rom16 : aliased constant String := "PUZZLE";
   Rom17 : aliased constant String := "SYZYGY";
   Rom18 : aliased constant String := "TANK";
   Rom19 : aliased constant String := "TETRIS";
   Rom20 : aliased constant String := "TICTAC";
   Rom21 : aliased constant String := "UFO";
   Rom22 : aliased constant String := "VBRIX";
   Rom23 : aliased constant String := "VERS";
   Rom24 : aliased constant String := "WIPEOFF";

     procedure Draw;

   function Get_Rom_Index return Integer;

end Menu;
