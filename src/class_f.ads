with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;

package Class_F is
  procedure LD (i : Opcode ; x : Integer; vm : in out Registers.Registers);
  procedure ADD (x : Integer; vm : in out Registers.Registers);
end Class_F;
