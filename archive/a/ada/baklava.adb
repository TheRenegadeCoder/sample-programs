with Ada.Text_IO; use Ada.Text_IO;

procedure Baklava is
  M : Integer := 11;
begin
   for I in 1 .. 11 loop
      for J in 1 .. (M-1) loop
        Put(" ");
      end loop;
      for K in 1 .. (2*I - 1) loop
        Put("*");
      end loop;
      M := M -1;
      Put_Line("");
   end loop;
   M:=2;
   for I in reverse 1 .. 10 loop
      for J in 1 .. (M-1) loop
        Put(" ");
      end loop;
      for K in 1 .. (2*I - 1) loop
        Put("*");
      end loop;
      M := M + 1;
      Put_Line("");
   end loop;
end Baklava;