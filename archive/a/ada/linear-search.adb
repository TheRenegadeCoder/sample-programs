with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Maps;  use Ada.Strings.Maps;
with Ada.Containers.Vectors;

procedure Linear_Search is

   Data_Format_Error : exception;

   function Clean (S : String) return String
   is (Trim (S, Ada.Strings.Both));

   function To_Int (S : String) return Integer is
      Cleaned : constant String := Clean (S);
   begin
      return Integer'Value (Cleaned);
   exception
      when Constraint_Error =>
         raise Data_Format_Error with "Invalid integer: '" & Cleaned & "'";
   end To_Int;

   package Integer_Vectors is new
     Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Integer);

   subtype Int_List is Integer_Vectors.Vector;

   function Found (Within : Int_List; Item : Integer) return Boolean is
      use Integer_Vectors;
   begin
      return Within.Find (Item) /= No_Element;
   end Found;

   function To_Int_List (Raw_String : String) return Int_List is
      Result : Int_List;
      Start  : Positive := Raw_String'First;
      Finish : Natural;
      Seps   : constant Character_Set := To_Set (", ");
   begin
      while Start <= Raw_String'Last loop
         Find_Token
           (Raw_String, Seps, Start, Ada.Strings.Outside, Start, Finish);

         exit when Start > Finish;

         Result.Append (To_Int (Raw_String (Start .. Finish)));

         Start := Finish + 1;
      end loop;

      if Result.Is_Empty then
         raise Data_Format_Error with "List is empty";
      end if;

      return Result;
   end To_Int_List;

   procedure Print_Usage is
   begin
      Put_Line
        ("Usage: please provide a list of integers (""1, 4, 5, 11, 12"") and the integer to find (""11"")");
   end Print_Usage;

begin
   if Argument_Count /= 2 then
      Print_Usage;
      Set_Exit_Status (Failure);
      return;
   end if;

   begin
      declare
         Haystack : constant Int_List := To_Int_List (Argument (1));
         Needle   : constant Integer := To_Int (Argument (2));
      begin
         Put_Line (if Found (Haystack, Needle) then "true" else "false");
      end;
   exception
      when Data_Format_Error | Constraint_Error =>
         Print_Usage;
         Set_Exit_Status (Failure);
   end;

end Linear_Search;
