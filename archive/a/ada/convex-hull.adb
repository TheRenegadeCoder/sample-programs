with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Command_Line;  use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Containers;    use Ada.Containers;
with Ada.Containers.Vectors;

procedure Convex_Hull is

   Input_Error : exception;

   type Point is record
      X, Y : Integer;
   end record;

   function Cross_Product (O, A, B : Point) return Integer
   is ((A.X - O.X) * (B.Y - O.Y) - (A.Y - O.Y) * (B.X - O.X));

   function "<" (Left, Right : Point) return Boolean
   is (Left.X < Right.X or else (Left.X = Right.X and then Left.Y < Right.Y));

   package Int_Vectors is new
     Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Integer);

   package Point_Vectors is new
     Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Point);

   package Point_Sorting is new Point_Vectors.Generic_Sorting;

   function Parse_List (S : String) return Int_Vectors.Vector is
      V           : Int_Vectors.Vector;
      Token_Start : Positive := S'First;
   begin
      if S'Length = 0 then
         raise Input_Error;
      end if;

      for I in S'Range loop
         if S (I) = ',' or else I = S'Last then
            declare
               Token_End : constant Natural :=
                 (if S (I) = ',' then I - 1 else I);

               Token : constant String :=
                 Trim (S (Token_Start .. Token_End), Ada.Strings.Both);
            begin
               if Token'Length = 0 then
                  raise Input_Error;
               end if;

               V.Append (Integer'Value (Token));
            end;

            Token_Start := I + 1;
         end if;
      end loop;

      return V;

   exception
      when others =>
         raise Input_Error;
   end Parse_List;

   function Convex_Hull_Of
     (Pts : Point_Vectors.Vector) return Point_Vectors.Vector
   is
      use Point_Vectors;
      Sorted : Vector := Pts;
      Lower  : Vector;
      Upper  : Vector;
   begin
      Point_Sorting.Sort (Sorted);

      for P of Sorted loop
         while Lower.Length >= 2 loop
            declare
               A : constant Point := Lower.Element (Lower.Last_Index - 1);
               B : constant Point := Lower.Element (Lower.Last_Index);
            begin
               exit when Cross_Product (A, B, P) > 0;
               Lower.Delete_Last;
            end;
         end loop;

         Lower.Append (P);
      end loop;

      for I in reverse Sorted.First_Index .. Sorted.Last_Index loop
         declare
            P : constant Point := Sorted.Element (I);
         begin
            while Upper.Length >= 2 loop
               declare
                  A : constant Point := Upper.Element (Upper.Last_Index - 1);
                  B : constant Point := Upper.Element (Upper.Last_Index);
               begin
                  exit when Cross_Product (A, B, P) > 0;
                  Upper.Delete_Last;
               end;
            end loop;

            Upper.Append (P);
         end;
      end loop;

      if Lower.Length > 0 then
         Lower.Delete_Last;
      end if;

      if Upper.Length > 0 then
         Upper.Delete_Last;
      end if;

      for P of Upper loop
         Lower.Append (P);
      end loop;

      return Lower;
   end Convex_Hull_Of;

   procedure Print_Points (V : Point_Vectors.Vector) is
   begin
      for P of V loop
         Put_Line
           ("("
            & Trim (P.X'Image, Ada.Strings.Left)
            & ", "
            & Trim (P.Y'Image, Ada.Strings.Left)
            & ")");
      end loop;
   end Print_Points;

   procedure Print_Usage is
   begin
      Put_Line
        ("Usage: please provide at least 3 x and y coordinates as separate lists (e.g. ""100, 440, 210"")");
   end Print_Usage;

begin
   if Argument_Count /= 2 then
      Print_Usage;
      Set_Exit_Status (Failure);
      return;
   end if;

   begin
      declare
         Xs     : constant Int_Vectors.Vector := Parse_List (Argument (1));
         Ys     : constant Int_Vectors.Vector := Parse_List (Argument (2));
         Points : Point_Vectors.Vector;
      begin
         if Xs.Length /= Ys.Length or else Xs.Length < 3 then
            raise Input_Error;
         end if;

         for I in Xs.First_Index .. Xs.Last_Index loop
            Points.Append ((X => Xs.Element (I), Y => Ys.Element (I)));
         end loop;

         Print_Points (Convex_Hull_Of (Points));
      end;
   exception
      when Input_Error | Constraint_Error =>
         Print_Usage;
         Set_Exit_Status (Failure);
   end;

end Convex_Hull;
