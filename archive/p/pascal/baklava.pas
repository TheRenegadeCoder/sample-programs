program baklava;

var 
i, j, spacecount, starcount : integer;
begin
	(* Top Part *)
for i:= 0 to 10 do
	begin
			    spacecount := 10 - i;
				starcount := i*2 ;
				for j:= spacecount downto 1 do
				begin
					write(' ');

				end;

				for j:=0 to starcount do
				begin
				write('@');	

				end; 
		writeln();
	end;

(*Bottom Part*)
for i:= 10 downto 0 do
	begin
	    spacecount := 10 - i;
		starcount := i * 2;
		for j:= spacecount downto 1 do
		begin
			write(' ');
		end;


		for j:=0 to starcount do
		begin
		write('@');		
		end; 
				writeln();
	end;

	end.
