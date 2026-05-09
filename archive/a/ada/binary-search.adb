with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Containers.Vectors;

procedure Binary_Search is

   Parse_Error : exception;

   package Int_Vec is new
     Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Integer);

   use Int_Vec;

   function Contains (V : Vector; Value : Integer) return Boolean is
      Len  : constant Natural := Natural (Length (V));
      Low  : Natural := First_Index (V);
      High : Natural := Last_Index (V);
   begin
      if Len = 0 then
         return False;
      end if;

      while Low <= High loop
         declare
            Mid     : constant Natural := Low + (High - Low) / 2;
            Mid_Val : constant Integer := Element (V, Mid);
         begin
            if Value < Mid_Val then
               if Mid = 0 then
                  exit;
               end if;
               High := Mid - 1;

            elsif Mid_Val < Value then
               Low := Mid + 1;

            else
               return True;
            end if;
         end;
      end loop;

      return False;
   end Contains;

   function Parse_Int (S : String) return Integer is
      Clean : constant String := Trim (S, Ada.Strings.Both);
   begin
      if Clean'Length = 0 then
         raise Parse_Error;
      end if;

      return Integer'Value (Clean);
   exception
      when others =>
         raise Parse_Error;
   end Parse_Int;

   function Parse_Sorted_List (S : String) return Vector is
      V          : Vector;
      Start      : Positive := S'First;
      First_Item : Boolean := True;
      Prev       : Integer := 0;
   begin
      if S'Length = 0 then
         raise Parse_Error;
      end if;

      for I in S'Range loop
         if S (I) = ',' then
            declare
               Value : constant Integer := Parse_Int (S (Start .. I - 1));
            begin
               if not First_Item and then Value < Prev then
                  raise Parse_Error;  -- not sorted

               end if;

               Append (V, Value);
               Prev := Value;
               First_Item := False;
               Start := I + 1;
            end;
         end if;
      end loop;

      declare
         Value : constant Integer := Parse_Int (S (Start .. S'Last));
      begin
         if not First_Item and then Value < Prev then
            raise Parse_Error;
         end if;

         Append (V, Value);
      end;

      return V;
   end Parse_Sorted_List;

   procedure Print_Usage is
   begin
      Put_Line
        ("Usage: please provide a list of sorted integers (""1, 4, 5, 11, 12"") and the integer to find (""11"")");
   end Print_Usage;

begin
   if Argument_Count /= 2 then
      Print_Usage;
      Set_Exit_Status (Failure);
      return;
   end if;

   declare
      Haystack : Vector;
      Needle   : Integer;
   begin
      Haystack := Parse_Sorted_List (Argument (1));
      Needle := Parse_Int (Argument (2));

      Put_Line (if Contains (Haystack, Needle) then "true" else "false");

   exception
      when Parse_Error | Constraint_Error =>
         Print_Usage;
         Set_Exit_Status (Failure);
   end;

end Binary_Search;
