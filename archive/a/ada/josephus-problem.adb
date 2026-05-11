pragma Ada_2022;
with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

procedure Josephus is

   subtype Population is Positive;
   subtype Step_Size is Positive;

   function Survivor_Index
     (Count : Population; Skip : Step_Size) return Positive
   is
      Result : Natural := 0;
   begin
      for I in 2 .. Count loop
         Result := (@ + Skip) mod I;
      end loop;

      return Result + 1;
   end Survivor_Index;

   procedure Print_Usage is
   begin
      Put_Line
        ("Usage: please input the total number of people and number of people to skip.");
   end Print_Usage;

begin
   if Argument_Count /= 2 then
      Print_Usage;
      return;
   end if;

   declare
      Total : constant Population := Population'Value (Argument (1));
      Skip  : constant Step_Size := Step_Size'Value (Argument (2));
   begin
      Put_Line (Trim (Survivor_Index (Total, Skip)'Image, Ada.Strings.Left));
   end;

exception
   when Constraint_Error =>
      Print_Usage;
      Set_Exit_Status (Failure);
end Josephus;
