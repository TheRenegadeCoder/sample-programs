with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

procedure Even_Odd is

   procedure Print_Usage is
   begin
      Put_Line ("Usage: please input a number");
   end Print_Usage;

begin
   if Argument_Count /= 1 then
      Print_Usage;
      return;
   end if;

   declare
      Value : Integer;
   begin
      Value := Integer'Value (Argument (1));
      Put_Line (if Value rem 2 = 0 then "Even" else "Odd");

   exception
      when Constraint_Error =>
         Print_Usage;
   end;

end Even_Odd;
