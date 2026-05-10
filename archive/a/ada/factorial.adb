with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

procedure Factorial is

   procedure Print_Usage is
   begin
      Put_Line ("Usage: please input a non-negative integer");
   end Print_Usage;

   function Fact (N : Natural) return Natural is
      Result : Natural := 1;
   begin
      for I in 2 .. N loop
         Result := Result * I;
      end loop;
      return Result;
   end Fact;

   Max_Allowed : constant Natural := 12; -- Fact (13) > Natural'Last

begin
   if Argument_Count /= 1 then
      Print_Usage;
      return;
   end if;

   declare
      N : Natural;
   begin
      N := Natural'Value (Argument (1));

      if N > Max_Allowed then
         Print_Usage;
         return;
      end if;

      Put_Line (Natural'Image (Fact (Natural (N))));

   exception
      when Constraint_Error =>
         Print_Usage;
   end;

end Factorial;
