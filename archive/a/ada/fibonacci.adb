with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

procedure Fibonacci is

   procedure Print_Usage is
   begin
      Put_Line
        ("Usage: please input the count of fibonacci numbers to output");
   end Print_Usage;

   function Img (N : Natural) return String
   is (Trim (Natural'Image (N), Ada.Strings.Left));

begin
   if Argument_Count /= 1 then
      Print_Usage;
      return;
   end if;

   declare
      N : Natural;
   begin
      begin
         N := Natural'Value (Argument (1));
      exception
         when Constraint_Error =>
            Print_Usage;
            return;
      end;

      if N = 0 then
         return;
      end if;

      declare
         A, B : Natural := 1;
         Next : Natural;
      begin
         for I in 1 .. N loop
            Put_Line (Img (I) & ": " & Img (A));

            Next := A + B;
            A := B;
            B := Next;
         end loop;
      end;
   end;

end Fibonacci;
