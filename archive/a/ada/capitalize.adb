with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Characters.Handling;

procedure Capitalize is

   use Ada.Characters.Handling;

   function Capitalize (S : String) return String is
      Result : String := S;
   begin
      Result (Result'First) := To_Upper (Result (Result'First));
      return Result;
   end Capitalize;

begin
   if Argument_Count /= 1 or else Argument (1)'Length = 0 then
      Put_Line ("Usage: please provide a string");
      Set_Exit_Status (Failure);
      return;
   end if;

   Put_Line (Capitalize (Argument (1)));

end Capitalize;
