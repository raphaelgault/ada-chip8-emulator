with Types; use Types;

package Stack is
  Stack_Max_Size : constant Integer := 16;
  Type Data is array (1 .. Stack_Max_Size) of Types.Integer_16;
  type FifoStack is record
    Size : Integer range 0 .. Stack_Max_Size;
    IntData : Data;
  end record;
  function Stack_Push (s : in out FifoStack; elt : Types.Integer_16) return Boolean;
  function Stack_Pop (s : in out FifoStack) return Types.Integer_16;
end Stack;
