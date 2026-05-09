with Ada.Command_Line;                  use Ada.Command_Line;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Strings.Fixed;                 use Ada.Strings.Fixed;
with Ada.Text_IO;                       use Ada.Text_IO;
with Ada.Containers;                    use Ada.Containers;
with Ada.Containers.Vectors;

procedure Depth_First_Search is
   Data_Format_Error : exception;

   package Integer_Lists is new
     Ada.Containers.Vectors (Index_Type => Natural, Element_Type => Integer);

   subtype Int_List is Integer_Lists.Vector;
   type Boolean_Array is array (Natural range <>) of Boolean;

   function To_Int_List (Raw_Input : String) return Int_List is
      Result : Int_List;

      function Clean_Item (S : String) return String is
         Item : constant String := Trim (S, Ada.Strings.Both);
      begin
         if Item'Length = 0 then
            raise Data_Format_Error;
         end if;
         return Item;
      end Clean_Item;

      procedure Append_Item (S : String) is
      begin
         Result.Append (Integer'Value (Clean_Item (S)));
      exception
         when Constraint_Error =>
            raise Data_Format_Error;
      end Append_Item;

      Start     : Positive := Raw_Input'First;
      Separator : Natural;
   begin
      if Raw_Input'Length = 0 then
         raise Data_Format_Error;
      end if;

      loop
         Separator := Index (Raw_Input (Start .. Raw_Input'Last), ",");

         declare
            Last_Index : constant Positive :=
              (if Separator = 0 then Raw_Input'Last else Separator - 1);
         begin
            Append_Item (Raw_Input (Start .. Last_Index));
         end;

         exit when Separator = 0;
         Start := Separator + 1;
      end loop;

      return Result;
   end To_Int_List;

   function Cell
     (Graph : Int_List; Rows : Natural; From, To : Natural) return Boolean
   is (Graph.Element (From * Rows + To) = 1);

   function Has_Path_To
     (Target  : Integer;
      Node    : Natural;
      Grid    : Int_List;
      Labels  : Int_List;
      Order   : Natural;
      Visited : in out Boolean_Array) return Boolean is
   begin
      if Visited (Node) then
         return False;
      end if;

      if Labels.Element (Node) = Target then
         return True;
      end if;

      Visited (Node) := True;

      for Neighbor in Visited'Range loop
         if Cell (Grid, Order, Node, Neighbor) and then not Visited (Neighbor)
         then
            if Has_Path_To (Target, Neighbor, Grid, Labels, Order, Visited)
            then
               return True;
            end if;
         end if;
      end loop;

      return False;
   end Has_Path_To;

   procedure Print_Usage is
   begin
      Put_Line
        ("Usage: please provide a tree in an adjacency matrix form "
         & "(""0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, "
         & "0, 0, 1, 0, 0, 0, 0, 1, 0, 0"") together with a list of vertex values "
         & "(""1, 3, 5, 2, 4"") and the integer to find (""4"")");
   end Print_Usage;

begin
   if Argument_Count /= 3 then
      Print_Usage;
      Set_Exit_Status (Failure);
      return;
   end if;

   declare
      Adjacency_Data : constant Int_List := To_Int_List (Argument (1));
      Vertex_Values  : constant Int_List := To_Int_List (Argument (2));
      Target_Search  : constant Integer := Integer'Value (Argument (3));
      Total_Cells    : constant Natural := Natural (Adjacency_Data.Length);
      Matrix_Size    : constant Natural :=
        Natural (Sqrt (Float (Total_Cells)));

   begin
      if Matrix_Size * Matrix_Size /= Total_Cells
        or else Matrix_Size /= Natural (Vertex_Values.Length)
      then
         raise Data_Format_Error;
      end if;

      declare
         Seen : Boolean_Array (0 .. Matrix_Size - 1) := (others => False);

         Found : constant Boolean :=
           (Matrix_Size > 0
            and then
              Has_Path_To
                (Target  => Target_Search,
                 Node    => 0,
                 Grid    => Adjacency_Data,
                 Labels  => Vertex_Values,
                 Order   => Matrix_Size,
                 Visited => Seen));

      begin
         if Found then
            Put_Line ("true");
         else
            Put_Line ("false");
         end if;
      end;
   end;

exception
   when Data_Format_Error | Constraint_Error =>
      Print_Usage;
      Set_Exit_Status (Failure);
end Depth_First_Search;
