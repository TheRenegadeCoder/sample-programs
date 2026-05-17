pragma Ada_2022;

with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

procedure Longest_Palindromic_Substring is

   procedure Print_Usage is
   begin
      Put_Line
        ("Usage: please provide a string that contains at least one palindrome");
   end Print_Usage;

   function LPS (S : String) return String is
      N : constant Natural := S'Length;

      Transformed : String (1 .. 2 * N + 1);
      Radius      : array (1 .. 2 * N + 1) of Natural := (others => 0);

      Center : Natural := 1;
      Right  : Natural := 1;

      Best_Center : Natural := 1;
      Best_Radius : Natural := 0;

   begin
      -- build: #a#b#c#
      Transformed (1) := '#';
      for I in 1 .. N loop
         Transformed (2 * I) := S (I);
         Transformed (2 * I + 1) := '#';
      end loop;

      for I in 2 .. Transformed'Last loop

         if I < Right then
            Radius (I) := Natural'Min (Right - I, Radius (2 * Center - I));
         end if;

         while I + Radius (I) + 1 <= Transformed'Last
           and then I - Radius (I) - 1 >= 1
           and then
             Transformed (I + Radius (I) + 1)
             = Transformed (I - Radius (I) - 1)
         loop
            Radius (I) := Radius (I) + 1;
         end loop;

         if I + Radius (I) > Right then
            Center := I;
            Right := I + Radius (I);
         end if;

         if Radius (I) > Best_Radius then
            Best_Radius := Radius (I);
            Best_Center := I;
         end if;

      end loop;

      declare
         Start : constant Natural := (Best_Center - Best_Radius) / 2;
      begin
         if Best_Radius < 2 then
            return "";
         end if;

         return S (Start + 1 .. Start + Best_Radius);
      end;
   end LPS;

begin

   if Argument_Count /= 1 then
      Print_Usage;
      return;
   end if;

   declare
      Input  : constant String := Argument (1);
      Result : constant String := LPS (Input);
   begin

      if Input'Length = 0 or else Result'Length = 0 then
         Print_Usage;
         return;
      else
         Put_Line (Result);
      end if;

   exception
      when others =>
         Print_Usage;
   end;

end Longest_Palindromic_Substring;