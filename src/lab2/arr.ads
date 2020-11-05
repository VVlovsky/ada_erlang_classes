package Arr is

type Float_Array is array (Integer range <>) of Float;
procedure Console_Out(A: Float_Array);
procedure Fill(A: out Float_Array);
function Check_Sort(A: Float_Array) return Boolean;
procedure Bubble_Sort(A: in out Float_Array);
end Arr;