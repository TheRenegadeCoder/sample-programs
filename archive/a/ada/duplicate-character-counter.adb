pragma Ada_2022;

with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Command_Line;        use Ada.Command_Line;
with Ada.Characters.Handling; use Ada.Characters.Handling;

with Ada.Containers.Hashed_Maps;

procedure Duplicate_Character_Counter is

   function Hash (C : Character) return Ada.Containers.Hash_Type
   is (Ada.Containers.Hash_Type (Character'Pos (C)));

   function Equivalent (L, R : Character) return Boolean
   is (L = R);

   package Char_Count_Map is new
     Ada.Containers.Hashed_Maps
       (Key_Type        => Character,
        Element_Type    => Natural,
        Hash            => Hash,
        Equivalent_Keys => Equivalent);

   use Char_Count_Map;

   function Count (Input : String) return Map is
      M : Map;
   begin
      for C of Input loop
         if Is_Alphanumeric (C) then
            if M.Contains (C) then
               M.Replace (C, M.Element (C) + 1);
            else
               M.Insert (C, 1);
            end if;
         end if;
      end loop;

      return M;
   end Count;

   procedure Print_Duplicates (Input : String; M : Map) is
      Seen  : array (Character) of Boolean := [others => False];
      Found : Boolean := False;
   begin
      for C of Input loop
         if Is_Alphanumeric (C)
           and then M.Contains (C)
           and then M.Element (C) > 1
           and then not Seen (C)
         then
            Put_Line (C & ":" & Natural'Image (M.Element (C)));
            Seen (C) := True;
            Found := True;
         end if;
      end loop;

      if not Found then
         Put_Line ("No duplicate characters");
      end if;
   end Print_Duplicates;

   Input : constant String :=
     (if Argument_Count = 1 then Argument (1) else "");

begin
   if Input = "" then
      Put_Line ("Usage: please provide a string");
      Set_Exit_Status (Failure);
      return;
   end if;

   declare
      M : constant Map := Count (Input);
   begin
      Print_Duplicates (Input, M);
   end;

end Duplicate_Character_Counter;
