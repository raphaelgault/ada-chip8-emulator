with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;

package Handlers is
  function rshift(val : opcode; num : Integer) return Opcode;
  function lshift(val : opcode; num : Integer) return Opcode;

  procedure handler_0 (i : in Opcode; vm : in out Registers.Registers);

  procedure handler_1 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure handler_2 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure handler_3 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure handler_4 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure handler_5 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure handler_6 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.GeneralRegisters(Integer(rshift(i and 16#0F00#, 8))) = Byte(i and 16#00FF#);

  procedure handler_7 (i : in Opcode; vm : in out Registers.Registers);

  procedure handler_8 (i : in Opcode; vm : in out Registers.Registers);

  procedure handler_9 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;
  procedure handler_A (i : in Opcode; vm : in out Registers.Registers);

  procedure handler_B (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure handler_C (i : in Opcode; vm : in out Registers.Registers);

  procedure handler_D (i : in Opcode; vm : in out Registers.Registers) with
    Pre => VM. Refresh_Screen = False,
    Post => VM.Refresh_Screen = True;
  procedure handler_E (i : in Opcode; vm : in out Registers.Registers);

  procedure handler_F (i : in Opcode; vm : in out Registers.Registers);

  type Class_Handler is access procedure (i : in Opcode;
                                          vm : in out Registers.Registers);
  type Instr_Classes is array (0 .. 15) of Class_Handler;

  Handler_Table : Instr_Classes := (handler_0'Access, handler_1'Access,
                                    handler_2'Access, handler_3'Access,
                                    handler_4'Access, handler_5'Access,
                                    handler_6'Access, handler_7'Access,
                                    handler_8'Access, handler_9'Access,
                                    handler_A'Access, handler_B'Access,
                                    handler_C'Access, handler_D'Access,
                                    handler_E'Access, handler_F'Access);
end Handlers;
