program baklava;
(* Print 10 lines of Sweet Baklava
   Note: Pascal Loops are inclusive of ends i.e., 
   for i:= 0 to 10 will run 11 times .*)
var 
i, j, spacecount, starcount : integer;
begin
(* Top Part *)
for i:= 0 to 10 do
	begin
		spacecount := 10 - i;
		starcount := i*2;
    (* Print Spaces*)
		for j:= spacecount downto 0 do
		begin
			write(' ');
		end;
    (*Print Stars*)
		for j:=0 to starcount do
		begin
		  write('*');	
		end; 
		writeln();
	end;
(*Bottom Part*)
for i:= 9 downto 0 do
	begin
	    spacecount := 10 - i;
		starcount := i * 2;
    (* Print Spaces*)
		for j:= spacecount downto 0 do
		begin
			write(' ');
		end;
    (* Print Stars*)
		for j:=0 to starcount do
		begin
		  write('*');		
		end; 
		writeln();
	end;
end.
