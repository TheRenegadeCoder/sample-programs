pragma Ada_2022;

with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

procedure Longest_Word is
   function Is_Separator (Ch : Character) return Boolean
   is (Ch = ' ' or else Ch = ASCII.LF or else Ch = ASCII.HT);

   function Longest_Word (S : String) return Natural is
      Max_Len : Natural := 0;
      Curr    : Natural := 0;
   begin
      for Ch of S loop
         if Is_Separator (Ch) then
            Max_Len := Natural'Max (Max_Len, Curr);
            Curr := 0;
         else
            Curr := @ + 1;
         end if;
      end loop;

      return Natural'Max (Max_Len, Curr);
   end Longest_Word;

   procedure Print_Usage is
   begin
      Put_Line ("Usage: please provide a string");
   end Print_Usage;

begin
   if Argument_Count /= 1 then
      Print_Usage;
      return;
   end if;

   declare
      Input : constant String := Argument (1);
   begin
      if Input'Length = 0 then
         Print_Usage;
         return;
      end if;

      Put_Line (Natural'Image (Longest_Word (Input)));
   end;

end Longest_Word;
