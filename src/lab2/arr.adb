with Ada.Text_IO, Ada.Numerics.Float_Random;

package body Arr is


    procedure Console_Out (A : Float_Array) is
    begin
        for Index in A'First .. A'Last loop
            Ada.Text_IO.Put_Line ("Element at the index" & Index'Img & " in the Array is" & A (Index)'Img);
        end loop;
    end Console_Out;


    procedure Fill (A : out Float_Array) is
        Generator : Ada.Numerics.Float_Random.Generator;
    begin
        for Index in A'First .. A'Last loop
            A (Index) := Ada.Numerics.Float_Random.Random (Generator);
        end loop;
    end Fill;


    procedure Bubble_Sort (A : in out Float_Array) is
        Need_To_Sort : Boolean := True;
        Tmp : Float := 0.0;
        Last_Index : Integer := 1;
    begin
        while Need_To_Sort loop
            Need_To_Sort := False;
            for I in A'First .. (A'Last - Last_Index) loop
                if A (I) > A (I+1) then
                    Tmp := A (I+1);
                    A (I+1) := A (I);
                    A (I) := Tmp;
                    Need_To_Sort := True;
                end if;
            end loop;
            Last_Index := Last_Index + 1;
        end loop;
    end Bubble_Sort;


    function Check_Sort (A : Float_Array) return Boolean is
    begin
        return (for all Index in A'First .. (A'Last - 1) => A (Index + 1) >= A (Index));
    end Check_Sort;


end Arr;