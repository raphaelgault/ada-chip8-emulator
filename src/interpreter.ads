with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Stack; use Stack;
with Types; use Types;
with Rom; use Rom;
with Handlers; use Handlers;
with Registers; use Registers;
with Interfaces; use Interfaces;

package Interpreter is

   procedure Interprete;

end Interpreter;
