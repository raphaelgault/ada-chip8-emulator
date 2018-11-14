package body Stack is
  function Stack_Push (s : in out FifoStack; elt : Integer_16) return Boolean is
  begin
    if s.Size >= Stack_Max_Size then
      return False;
    end if;
    s.Size := s.Size + 1;
    s.IntData(s.Size) := elt;
    return True;
  end;
  function Stack_Pop (s : in out FifoStack) return Integer_16 is
    elt : Integer_16;
  begin
    if s.Size < 1 then
      return -1;
    end if;
    elt := s.IntData(s.Size);
    s.Size := s.Size - 1;
    return elt;
  end;
end Stack;
