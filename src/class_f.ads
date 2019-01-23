with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;

package Class_F is
   procedure LD (i : Opcode ; x : Integer; vm : in out Registers.Registers) with
     Pre => Integer(I) >= 0 and then Integer(I) <= 16#FF# and then
     Byte(I and 16#FF#) in 16#07# | 16#0A# | 16#15# | 16#18# | 16#29# | 16#33# | 16#55# | 16#65#,
     Post => VM.I <= 16#FF# and then VM.DT <= 16#FF#;

  procedure ADD (x : Integer; vm : in out Registers.Registers) with
    Pre => X >= 0 and then X <= 15,
    Post => VM.I >= 0 and then VM.I <= 16#FF#;
end Class_F;
