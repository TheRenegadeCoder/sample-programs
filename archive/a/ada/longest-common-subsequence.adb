pragma Ada_2022;

with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Maps;  use Ada.Strings.Maps;
with Ada.Containers.Vectors;

procedure Longest_Common_Subsequence is

   Data_Format_Error : exception;

   package Integer_Vectors is new
     Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Integer);
   use Integer_Vectors;

   subtype Int_List is Integer_Vectors.Vector;

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
        ("Usage: please provide two lists in the format ""1, 2, 3, 4, 5""");
   end Print_Usage;

   function LCS (A, B : Int_List) return Int_List is
      N : constant Natural := Natural (A.Length);
      M : constant Natural := Natural (B.Length);

      DP     : array (0 .. N, 0 .. M) of Natural := (others => (others => 0));
      Result : Int_List;

   begin
      for I in 1 .. N loop
         for J in 1 .. M loop

            declare
               X : constant Integer := Element (A, I - 1);
               Y : constant Integer := Element (B, J - 1);
            begin
               if X = Y then
                  DP (I, J) := DP (I - 1, J - 1) + 1;
               else
                  DP (I, J) := Natural'Max (DP (I - 1, J), DP (I, J - 1));
               end if;
            end;

         end loop;
      end loop;

      declare
         I : Natural := N;
         J : Natural := M;
      begin
         while I > 0 and J > 0 loop

            declare
               X : constant Integer := Element (A, I - 1);
               Y : constant Integer := Element (B, J - 1);
            begin
               if X = Y then
                  Result.Prepend (X);
                  I := I - 1;
                  J := J - 1;

               elsif DP (I - 1, J) >= DP (I, J - 1) then
                  I := I - 1;
               else
                  J := J - 1;
               end if;
            end;

         end loop;
      end;

      return Result;
   end LCS;

   procedure Print_List (V : Int_List) is
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
   end Print_List;

begin
   if Argument_Count /= 2 then
      Print_Usage;
      return;
   end if;

   begin
      declare
         A : constant Int_List := To_Int_List (Argument (1));
         B : constant Int_List := To_Int_List (Argument (2));
      begin
         if A.Is_Empty or else B.Is_Empty then
            raise Data_Format_Error;
         end if;

         Print_List (LCS (A, B));
      end;
   exception
      when Data_Format_Error | Constraint_Error =>
         Print_Usage;
   end;

end Longest_Common_Subsequence;
