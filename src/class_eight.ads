with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;

package Class_Eight is
  procedure LD (x : Integer; y : Integer; vm : in out Registers.Registers);
  procedure OR_instr (x : Integer; y : Integer;vm : in out Registers.Registers);
  procedure AND_instr (x : Integer; y : Integer;vm : in out Registers.Registers);
  procedure XOR_instr (x : Integer; y : Integer;vm : in out Registers.Registers);
  procedure ADD (x : Integer; y : Integer;vm : in out Registers.Registers);
  procedure SUB (x : Integer; y : Integer;vm : in out Registers.Registers);
  procedure SHR (x : Integer; y : Integer;vm : in out Registers.Registers);
  procedure SUBN (x : Integer; y : Integer;vm : in out Registers.Registers);
  procedure SHL (x : Integer; y : Integer;vm : in out Registers.Registers);

  type Eight_Instr_Handler is access procedure (x : Integer; y : Integer;
                                              vm : in out Registers.Registers);

  type Eight_Instructions is array (0 .. 8) of Eight_Instr_Handler;

  Instr_Table : Eight_Instructions := (LD'Access, OR_instr'Access, AND_instr'Access,
                                       XOR_instr'Access, ADD'Access, SUB'Access,
                                       SHR'Access, SUBN'Access, SHL'Access);
end Class_Eight;
