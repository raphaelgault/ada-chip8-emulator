with Ada.Numerics.Discrete_Random;

with Types; use Types;
with Registers; use Registers;
with Stack; use Stack;

with Class_E; use Class_E;
with Class_Eight; use Class_Eight;
with Class_F; use Class_F;

package Handlers is
   pragma Spark_Mode;

  function rshift(val : opcode; num : Integer) return Opcode;

  function lshift(val : opcode; num : Integer) return Opcode;

  procedure Handler_0 (i : in Opcode; vm : in out Registers.Registers);

  procedure Handler_1 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure Handler_2 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure Handler_3 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure Handler_4 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure Handler_5 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure Handler_6 (i : in Opcode; vm : in out Registers.Registers);

  procedure Handler_7 (i : in Opcode; vm : in out Registers.Registers);

  procedure Handler_8 (i : in Opcode; vm : in out Registers.Registers)
    with Pre => (I and 16#F#) < 8 or (I and 16#F#) = 14;

  procedure Handler_9 (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure Handler_A (i : in Opcode; vm : in out Registers.Registers)
    with Post => VM.I >= 0 and then VM.I <= 16#FF#;

  procedure Handler_B (i : in Opcode; vm : in out Registers.Registers)
    with Post => vm.pc >= 512 and then vm.pc <= 16#FFF#;

  procedure Handler_C (i : in Opcode; vm : in out Registers.Registers);

  procedure Handler_D (i : in Opcode; vm : in out Registers.Registers);

  procedure Handler_E (i : in Opcode; vm : in out Registers.Registers)
    with Pre => (I and 16#FF#) in 16#9E# | 16#A1#,
    Post => VM.PC >= 512 and then VM.PC <= 16#FF#;

  procedure Handler_F (i : in Opcode; vm : in out Registers.Registers)
    with Post => VM.I >= 0 and VM.I <= 16#FF#;

  type Class_Handler is access procedure (i : in Opcode;
                                          vm : in out Registers.Registers);

  type Instr_Classes is array (0 .. 15) of Class_Handler;

  Handler_Table : Instr_Classes := (Handler_0'Access, Handler_1'Access,
                                    Handler_2'Access, Handler_3'Access,
                                    Handler_4'Access, Handler_5'Access,
                                    Handler_6'Access, Handler_7'Access,
                                    Handler_8'Access, Handler_9'Access,
                                    Handler_A'Access, Handler_B'Access,
                                    Handler_C'Access, Handler_D'Access,
                                    Handler_E'Access, Handler_F'Access);
end Handlers;
