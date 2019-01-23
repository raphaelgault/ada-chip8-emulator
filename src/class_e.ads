with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;

package Class_E is

  procedure SKP (x : in Integer; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;
  procedure SKNP (x : in Integer; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

end Class_E;
