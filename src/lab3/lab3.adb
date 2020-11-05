with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Float_Random;

procedure lab3 is

type Element is
  record
    Data : Integer := 0;
    Next : access Element := Null;
  end record;

type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
  L : access Element := List;
begin
  if List = Null then
    Put_Line("List EMPTY!");
  else
    Put_Line("List:");
  end if;
  while L /= Null loop
    Put(L.Data, 4); -- z pakietu Ada.Integer_Text_IO
    New_Line;
    L := L.Next;
  end loop;
end Print;

procedure Insert(List : in out Elem_Ptr; D : in Integer) is
  E : Elem_Ptr := new Element;
begin
  E.Data := D;
  E.Next := List;
  -- lub E.all := (D, List);
  List := E;
end Insert;

-- wstawianie jako funkcja - wersja krótka
function Insert(List : access Element; D : in Integer) return access Element is
  ( new Element'(D,List) );

-- do napisania !!
procedure Insert_Sort(List : in out Elem_Ptr; D : in Integer) is
    E : Elem_Ptr := new Element;
    C : Elem_Ptr := List;
begin
    if C.Data > D then -- sprawdzamy pierwszy element osobno
        Insert(List, D);

    else
        while C.Next /= Null loop -- tu szukamy czy element listy ma następny element większy od E żeby umieścić go do E.Next
                                  -- i do elementu terażniejszego jako next dać element który mamy wstawić
            if C.Next.Data > D then
               E.Next := C.Next;
               E.Data := D;
               C.Next := E;
               exit; -- wychodzimy z pętli
            end if;
            C := C.Next;
        end loop;
    end if;
end Insert_Sort;

procedure Rand_Fill(List: in out Elem_Ptr; L: in Integer) is
    G: Generator;
begin
    for Tmp in 0..L loop
        Insert(List, Integer(Random(G) * 100.0)); -- wstawiamy do listy randomowy element z zakresu 0..100 L razy
    end loop;
end Rand_Fill;


function Find(List: Elem_Ptr; E: Integer) return Elem_Ptr is
    C: Elem_Ptr := List;
begin
    while C.Next /= Null loop -- przechodzimy przez całą lisę
        if C.Data = E then
            return C; -- wysyłamy znalieziony element
        end if;
        C := C.Next;
    end loop;
    return Null; -- ..lub null jeżeli element nie został znalieziony
end Find;


procedure Delete(List: in out Elem_Ptr; E: in Integer) is
    C: Elem_Ptr := List;
    Prev_E: Elem_Ptr := Null;  -- tworzymy pomocniczy wskażnik przechowujący element poprzedni od C
begin
    if List.Data = E then  -- tu najpierw sprawdzamy pierwszy element
        List := List.Next;
    else
        while C /= Null loop  -- przechodzimy przez listę aż nie trafimy na szukany element
            if C.Data = E then  --gdyż go znajdujemy to poprostu poprzedni od C element jako next otrzymuje następny od C element
                Prev_E.Next := C.Next;
                exit;
            else
                Prev_E := C;
                C := C.Next;
            end if;
        end loop;
    end if;
end Delete;


procedure Clean(List: Elem_Ptr) is
    C: Elem_Ptr := List;
    E: Elem_Ptr := Null;
begin
    while C /= Null loop --przechodzimy przez całą listę
        E := C;
        while E /= Null and then E.Data = C.Data loop --zakładając że lista jest posortowana dochodzimy do ostatniego
            E := E.Next;                              --duplikatu i przełączamy go
        end loop;
        C.Next := E;
        C := C.next;
    end loop;
end Clean;

Lista : Elem_Ptr := Null;

begin
  Print(Lista);
  Lista := Insert(Lista, 21);
  Insert_Sort(Lista, 11);
  Print(Lista);
  Insert(Lista, 20);

  Print(Lista);
  for I in reverse 1..12 loop
  Insert(Lista, I);
  end loop;
  Insert_Sort(Lista, 11);
  Delete(Lista, 3);
  Clean(Lista);
  Print(Lista);
end lab3;