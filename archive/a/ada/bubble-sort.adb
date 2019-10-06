procedure Main is
    type Bubble_Array is array (Integer range <>) of Integer;
    procedure Bubble_Sort (Arr : in out Bubble_Array) is
       Temp : Integer;
    begin
       for I in reverse Arr'Range loop
          for J in Arr'First .. I loop
    	 if Arr(I) < Arr(J) then
    	    Temp := Arr(J);
    	    Arr(J) := Arr(I);
    	    Arr(I) := Temp;
    	 end if;
          end loop;
       end loop;
    end Bubble_Sort;

Arr : Bubble_Array := (7, 3, 5, 5, 11);
begin
    Bubble_Sort(Arr);
end Main;
