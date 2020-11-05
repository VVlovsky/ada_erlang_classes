with Arr;


procedure Lab2 is

  T1 : Arr.Float_Array := (1..10 => 1.0);
begin
  Arr.Console_Out(T1);
  Arr.Fill(T1);
  Arr.Console_Out(T1);

  if Arr.Check_Sort(T1) then
    Arr.Console_Out(T1);
  else
    Arr.Bubble_Sort(T1);
    Arr.Console_Out(T1);
  end if;
end Lab2;