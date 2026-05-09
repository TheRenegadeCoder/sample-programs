with Ada.Command_Line;                  use Ada.Command_Line;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Strings.Fixed;                 use Ada.Strings.Fixed;
with Ada.Text_IO;                       use Ada.Text_IO;
with Ada.Containers;                    use Ada.Containers;
with Ada.Containers.Vectors;

procedure Dijkstra is
   Data_Format_Error : exception;

   package Integer_Vectors is new
     Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Integer);

   subtype Int_List is Integer_Vectors.Vector;

   INF : constant Integer := Integer'Last / 2;

   procedure Print_Usage is
   begin
      Put_Line
        ("Usage: please provide three inputs: a serialized matrix, a source node and a destination node");
   end Print_Usage;

   function To_Int_List (Raw : String) return Int_List is
      Result : Int_List;

      Start : Positive := Raw'First;
      Sep   : Natural;
   begin
      if Raw'Length = 0 then
         raise Data_Format_Error;
      end if;

      loop
         Sep := Index (Raw (Start .. Raw'Last), ",");

         declare
            Last : constant Positive :=
              (if Sep = 0 then Raw'Last else Sep - 1);

            Item : constant String :=
              Trim (Raw (Start .. Last), Ada.Strings.Both);
         begin
            Result.Append (Integer'Value (Item));
         end;

         exit when Sep = 0;
         Start := Sep + 1;
      end loop;

      return Result;
   end To_Int_List;

   function Dijkstra (Adj : Int_List; N, Src, Dst : Natural) return Integer is
      Dist : array (Natural range 0 .. N - 1) of Integer := (others => INF);
      Vis  : array (Natural range 0 .. N - 1) of Boolean := (others => False);

      function Min_Node return Natural is
         Best_Dist : Integer := INF;
         Best_Node : Natural := 0;
      begin
         for I in 0 .. N - 1 loop
            if not Vis (I) and then Dist (I) < Best_Dist then
               Best_Dist := Dist (I);
               Best_Node := I;
            end if;
         end loop;

         return Best_Node;
      end Min_Node;

      U, V : Natural;
      W    : Integer;
   begin
      Dist (Src) := 0;

      for Step in 0 .. N - 1 loop
         U := Min_Node;
         Vis (U) := True;

         for V_Index in 0 .. N - 1 loop
            W := Adj (U * N + V_Index);

            if W > 0 and then not Vis (V_Index) then
               if Dist (U) + W < Dist (V_Index) then
                  Dist (V_Index) := Dist (U) + W;
               end if;
            end if;
         end loop;
      end loop;

      return Dist (Dst);
   end Dijkstra;

begin

   if Argument_Count /= 3 then
      Print_Usage;
      return;
   end if;

   declare
      Adj_Str : constant String := Argument (1);
      Src_Str : constant String := Argument (2);
      Dst_Str : constant String := Argument (3);

      Adj      : Int_List;
      N        : Natural;
      Src, Dst : Natural;
      Result   : Integer;
   begin

      if Adj_Str'Length = 0
        or else Src_Str'Length = 0
        or else Dst_Str'Length = 0
      then
         Print_Usage;
         return;
      end if;

      begin
         Adj := To_Int_List (Adj_Str);
         Src := Natural'Value (Src_Str);
         Dst := Natural'Value (Dst_Str);
      exception
         when others =>
            Print_Usage;
            return;
      end;

      N := Natural (Sqrt (Float (Adj.Length)));

      if N = 0 or else N * N /= Natural (Adj.Length) then
         Print_Usage;
         return;
      end if;

      if Src >= N or else Dst >= N then
         Print_Usage;
         return;
      end if;

      for X of Adj loop
         if X < 0 then
            Print_Usage;
            return;
         end if;
      end loop;

      Result := Dijkstra (Adj, N, Src, Dst);

      if Result >= INF then
         Print_Usage;
      else
         Put_Line (Integer'Image (Result));
      end if;

   end;

end Dijkstra;
