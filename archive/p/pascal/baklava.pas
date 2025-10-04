program Baklava;

var
  n, i, j, k, space: integer;
begin
  n := 11;
  space := n - 1;
  for i := 1 to n do
  begin
    for j := 1 to space do
      write(' ');
    space := space - 1;
    for k := 1 to (2 * i - 1) do
      write('*');
    writeln;
  end;
  space := 1;
  for i := (n - 1) downto 1 do
  begin
    for j := 1 to space do
      write(' ');
    space := space + 1;
    for k := (2 * i - 1) downto 1 do
      write('*');
    writeln;
  end;
end.
