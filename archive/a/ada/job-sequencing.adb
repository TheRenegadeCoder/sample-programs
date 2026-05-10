pragma Ada_2022;

with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Strings.Fixed;
with Ada.Containers.Vectors;

procedure Job_Sequencing is
   package IO renames Ada.Text_IO;
   package CL renames Ada.Command_Line;
   package SF renames Ada.Strings.Fixed;

   Parse_Error : exception;

   package Job_Vec is new
     Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Integer);

   type Job is record
      Profit   : Integer;
      Deadline : Natural;
   end record;

   package Jobs_Vec is new
     Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Job);

   function To_Int (S : String) return Integer is
   begin
      return Integer'Value (SF.Trim (S, Ada.Strings.Both));
   exception
      when others =>
         raise Parse_Error;
   end To_Int;

   procedure Next_Token
     (S     : String;
      Pos   : in out Positive;
      First : out Positive;
      Last  : out Natural;
      Done  : out Boolean) is
   begin
      First := Pos;

      while Pos <= S'Last and then S (Pos) /= ',' loop
         Pos := Pos + 1;
      end loop;

      Last := Pos - 1;
      Done := Pos > S'Last;

      if not Done then
         Pos := Pos + 1; -- skip comma

      end if;
   end Next_Token;

   function Parse_Jobs (Profits_S, Deadlines_S : String) return Jobs_Vec.Vector
   is
      use Ada.Containers;
      Jobs : Jobs_Vec.Vector;

      PI : Positive := Profits_S'First;
      DI : Positive := Deadlines_S'First;

      Done_P, Done_D  : Boolean;
      P_First, P_Last : Positive;
      D_First, D_Last : Positive;

      function Next_Token
        (S     : String;
         Pos   : in out Positive;
         First : out Positive;
         Last  : out Natural;
         Done  : out Boolean) return Boolean is
      begin
         First := Pos;

         while Pos <= S'Last and then S (Pos) /= ',' loop
            Pos := Pos + 1;
         end loop;

         Last := Pos - 1;
         Done := Pos > S'Last;

         if not Done then
            Pos := Pos + 1;
         end if;

         return Done;
      end Next_Token;

   begin
      if Profits_S'Length = 0 or else Deadlines_S'Length = 0 then
         raise Parse_Error;
      end if;

      loop
         Next_Token (Profits_S, PI, P_First, P_Last, Done_P);
         Next_Token (Deadlines_S, DI, D_First, D_Last, Done_D);

         if Done_P /= Done_D then
            raise Parse_Error;
         end if;

         declare
            Profit : Integer := Integer'Value (Profits_S (P_First .. P_Last));

            Deadline : Natural :=
              Natural (Integer'Value (Deadlines_S (D_First .. D_Last)));
         begin
            Jobs.Append (Job'(Profit => Profit, Deadline => Deadline));
         end;

         exit when Done_P;
      end loop;

      if Jobs.Length < 2 then
         raise Parse_Error;
      end if;

      return Jobs;
   end Parse_Jobs;

   function By_Profit (L, R : Job) return Boolean
   is (L.Profit > R.Profit);

   package Job_Sort is new Jobs_Vec.Generic_Sorting (By_Profit);

   function Max_Profit (Jobs : Jobs_Vec.Vector) return Integer is
      Max_D : Natural := 0;
      Sum   : Integer := 0;
   begin
      for J of Jobs loop
         Max_D := Natural'Max (Max_D, J.Deadline);
      end loop;

      declare
         Slots : array (1 .. Max_D) of Boolean := (others => False);
      begin
         for J of Jobs loop
            for T in reverse 1 .. J.Deadline loop
               if not Slots (T) then
                  Slots (T) := True;
                  Sum := Sum + J.Profit;
                  exit;
               end if;
            end loop;
         end loop;
      end;

      return Sum;
   end Max_Profit;

   procedure Print_Usage is
   begin
      IO.Put_Line
        ("Usage: please provide a list of profits and a list of deadlines");
   end Print_Usage;

   Jobs : Jobs_Vec.Vector;

begin
   if CL.Argument_Count /= 2 then
      Print_Usage;
      CL.Set_Exit_Status (CL.Failure);
      return;
   end if;

   Jobs := Parse_Jobs (CL.Argument (1), CL.Argument (2));
   Job_Sort.Sort (Jobs);

   IO.Put_Line (Integer'Image (Max_Profit (Jobs)));

exception
   when Parse_Error =>
      Print_Usage;
      CL.Set_Exit_Status (CL.Failure);
end Job_Sequencing;
