with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;

package Class_E is
  procedure SKP (x : Integer; vm : in out Registers.Registers);
  procedure SKNP (x : Integer; vm : in out Registers.Registers);
end Class_E;
