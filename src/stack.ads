with Types; use Types;

package Stack is

  Stack_Max_Size : constant Integer := 16;

  Type Data is array (1 .. Stack_Max_Size) of Types.Integer_16;
  pragma Pack(Data);

  type LifoStack is record
    Size : Integer range 0 .. Stack_Max_Size;
    IntData : Data;
  end record;
  pragma Pack(LifoStack);

  function Stack_Init return LifoStack;

  function Stack_Push (s : in out LifoStack; elt : Types.Integer_16) return Boolean
      with Pre => s.Size < Stack_Max_Size,
        Post => s.Size'Old >= s.Size
        and then s.Size <= Stack_Max_Size;

  function Stack_Pop (s : in out LifoStack) return Types.Integer_16
      with Pre => s.Size > 0,
        Post => s.Size'Old <= s.Size
        and then s.Size >= 0;

  function Stack_Top (s : in LifoStack) return Types.Integer_16
      with Pre => s.Size > 0,
        Post => Stack_Top'Result = s.IntData(s.Size);

end Stack;
