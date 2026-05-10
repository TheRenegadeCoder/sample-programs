pragma Ada_2022;

with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Maps;  use Ada.Strings.Maps;
with Ada.Containers.Vectors;

procedure Maximum_Array_Rotation is

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

   function Max_Subarray (A : Int_List) return Integer is
      Current : Integer;
      Best    : Integer;

      Max_Element  : Integer;
      All_Negative : Boolean := True;
      First        : Boolean := True;
   begin
      if A.Is_Empty then
         return 0;
      end if;

      Max_Element := A.Element (A.First_Index);

      for X of A loop
         Max_Element := Integer'Max (@, X);
         All_Negative := @ and then X < 0;

         if First then
            Current := X;
            Best := X;
            First := False;
         else
            Current := Integer'Max (X, @ + X);
            Best := Integer'Max (@, Current);
         end if;
      end loop;

      return (if All_Negative then Max_Element else Best);
   end Max_Subarray;

   procedure Print_Usage is
   begin
      Put_Line
        ("Usage: Please provide a list of integers in the format: ""1, 2, 3, 4, 5""");
   end Print_Usage;

begin
   if Argument_Count /= 1 then
      Print_Usage;
      Set_Exit_Status (Failure);
      return;
   end if;

   begin
      declare
         Arr : constant Int_List := To_Int_List (Argument (1));
      begin
         Put_Line (Integer'Image (Max_Subarray (Arr)));
      end;
   exception
      when Data_Format_Error | Constraint_Error =>
         Print_Usage;
         Set_Exit_Status (Failure);
   end;

end Maximum_Array_Rotation;
