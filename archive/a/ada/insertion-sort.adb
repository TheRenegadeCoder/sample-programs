with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Containers.Vectors;

procedure Insertion_Sort is
   use Ada.Containers;

   Parse_Error : exception;

   package Int_Vec is new
     Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Integer);

   subtype Vec is Int_Vec.Vector;
   use Int_Vec;

   procedure Insertion_Sort (V : in out Vec) is
      Key  : Integer;
      Low  : Natural;
      High : Natural;
      Mid  : Natural;
      Pos  : Natural;
   begin
      if V.Length <= 1 then
         return;
      end if;

      for I in V.First_Index + 1 .. V.Last_Index loop
         Key := V (I);

         Low := V.First_Index;
         High := I;

         while Low < High loop
            Mid := Low + (High - Low) / 2;

            if V (Mid) <= Key then
               Low := Mid + 1;
            else
               High := Mid;
            end if;
         end loop;

         Pos := Low;

         for J in reverse Pos .. I - 1 loop
            V (J + 1) := V (J);
         end loop;

         V (Pos) := Key;
      end loop;
   end Insertion_Sort;

   function Parse_Int (S : String) return Integer is
      T : constant String := Trim (S, Ada.Strings.Both);
   begin
      return Integer'Value (T);
   exception
      when Constraint_Error =>
         raise Parse_Error;
   end Parse_Int;

   function Parse_List (S : String) return Vec is
      V     : Vec;
      Start : Positive := S'First;
   begin
      if S'Length = 0 then
         raise Parse_Error;
      end if;

      for I in S'Range loop
         if S (I) = ',' then
            if I = Start then
               raise Parse_Error;
            end if;

            Append (V, Parse_Int (S (Start .. I - 1)));
            Start := I + 1;
         end if;
      end loop;

      Append (V, Parse_Int (S (Start .. S'Last)));

      if V.Length < 2 then
         raise Parse_Error;
      end if;

      return V;
   end Parse_List;

   procedure Print_Vector (V : Vec) is
      First : constant Natural := V.First_Index;
      Last  : constant Natural := V.Last_Index;

      function Img (X : Integer) return String
      is (Trim (Integer'Image (X), Ada.Strings.Left));
   begin
      for I in First .. Last loop
         Put (Img (V (I)));
         if I /= Last then
            Put (", ");
         end if;
      end loop;
      New_Line;
   end Print_Vector;

   procedure Print_Usage is
   begin
      Put_Line
        ("Usage: please provide a list of at least two integers to sort in the format ""1, 2, 3, 4, 5""");
   end Print_Usage;

begin
   if Argument_Count /= 1 then
      Print_Usage;
      Set_Exit_Status (Failure);
      return;
   end if;

   declare
      V : Vec;
   begin
      V := Parse_List (Argument (1));
      Insertion_Sort (V);
      Print_Vector (V);

   exception
      when Parse_Error =>
         Print_Usage;
         Set_Exit_Status (Failure);
   end;
end Insertion_Sort;
