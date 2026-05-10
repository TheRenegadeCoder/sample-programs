pragma Ada_2022;

with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Command_Line;         use Ada.Command_Line;
with Ada.Strings.Fixed;        use Ada.Strings.Fixed;
with Ada.Strings.Text_Buffers; use Ada.Strings.Text_Buffers;

procedure Fraction_Math is

   package Fractions is
      type Fraction is private;

      function Make (N, D : Integer) return Fraction;
      function From_String (S : String) return Fraction;

      function "+" (A, B : Fraction) return Fraction;
      function "-" (A, B : Fraction) return Fraction;
      function "*" (A, B : Fraction) return Fraction;
      function "/" (A, B : Fraction) return Fraction;

      function "=" (A, B : Fraction) return Boolean;
      function "<" (A, B : Fraction) return Boolean;
      function ">" (A, B : Fraction) return Boolean;
      function "<=" (A, B : Fraction) return Boolean;
      function ">=" (A, B : Fraction) return Boolean;

   private
      type Fraction is record
         Num : Integer;
         Den : Positive;
      end record
      with Put_Image => Fraction_Put_Image;

      function Normalize (F : Fraction) return Fraction;
      function GCD (A, B : Integer) return Positive;
      procedure Fraction_Put_Image
        (Output : in out Root_Buffer_Type'Class; Value : Fraction);

   end Fractions;

   package body Fractions is

      function GCD (A, B : Integer) return Positive is
         X : Integer := abs A;
         Y : Integer := abs B;
         T : Integer;
      begin
         if X = 0 and Y = 0 then
            return 1;
         end if;

         while Y /= 0 loop
            T := X mod Y;
            X := Y;
            Y := T;
         end loop;

         return Positive (X);
      end GCD;

      function Normalize (F : Fraction) return Fraction is
         G : constant Positive := GCD (F.Num, F.Den);

         N : Integer := F.Num / Integer (G);
         D : Integer := F.Den / Integer (G);

         R : Fraction;
      begin
         if D < 0 then
            N := -N;
            D := -D;
         end if;

         R.Num := N;
         R.Den := Positive (D);

         return R;
      end Normalize;

      function Make (N, D : Integer) return Fraction is
      begin
         if D = 0 then
            raise Constraint_Error with "Denominator cannot be zero";
         end if;

         return Normalize ((Num => N, Den => Positive (abs D)));
      end Make;

      function From_String (S : String) return Fraction is
         Slash : constant Natural := Index (S, "/");
         N, D  : Integer;
      begin
         if Slash = 0 or else Slash = S'First or else Slash = S'Last then
            raise Constraint_Error with "Invalid fraction format (N/D)";
         end if;

         N := Integer'Value (S (S'First .. Slash - 1));
         D := Integer'Value (S (Slash + 1 .. S'Last));

         return Make (N, D);
      end From_String;

      procedure Fraction_Put_Image
        (Output : in out Root_Buffer_Type'Class; Value : Fraction)
      is
         use Ada.Strings.Fixed;

         function Img (X : Integer) return String
         is (Trim (Integer'Image (X), Ada.Strings.Left));
      begin
         Output.Put (Img (Value.Num));
         Output.Put ("/");
         Output.Put (Img (Value.Den));
      end Fraction_Put_Image;

      function "+" (A, B : Fraction) return Fraction
      is (Make (A.Num * B.Den + B.Num * A.Den, A.Den * B.Den));

      function "-" (A, B : Fraction) return Fraction
      is (Make (A.Num * B.Den - B.Num * A.Den, A.Den * B.Den));

      function "*" (A, B : Fraction) return Fraction
      is (Make (A.Num * B.Num, A.Den * B.Den));

      function "/" (A, B : Fraction) return Fraction is
      begin
         if B.Num = 0 then
            raise Constraint_Error with "Division by zero fraction";
         end if;

         return Make (A.Num * B.Den, A.Den * B.Num);
      end "/";

      function Compare (A, B : Fraction) return Integer is
         ALB : constant Long_Long_Integer :=
           Long_Long_Integer (A.Num) * Long_Long_Integer (B.Den);

         BRA : constant Long_Long_Integer :=
           Long_Long_Integer (B.Num) * Long_Long_Integer (A.Den);
      begin
         return (if ALB < BRA then -1 elsif ALB > BRA then 1 else 0);
      end Compare;

      function "=" (A, B : Fraction) return Boolean
      is (Compare (A, B) = 0);

      function "<" (A, B : Fraction) return Boolean
      is (Compare (A, B) < 0);

      function ">" (A, B : Fraction) return Boolean
      is (Compare (A, B) > 0);

      function "<=" (A, B : Fraction) return Boolean
      is (Compare (A, B) <= 0);

      function ">=" (A, B : Fraction) return Boolean
      is (Compare (A, B) >= 0);

   end Fractions;

   procedure Print_Usage is
   begin
      Put_Line ("Usage: ./fraction-math operand1 operator operand2");
   end Print_Usage;

   function Bool_To_Int (B : Boolean) return String
   is (Integer'Image (Boolean'Pos (B)));

begin
   if Argument_Count /= 3 then
      Print_Usage;
      return;
   end if;

   declare
      use Fractions;
      A, B : Fraction;
      Op   : constant String := Argument (2);
   begin
      A := From_String (Argument (1));
      B := From_String (Argument (3));

      if Op = "+" then
         Put_Line (Fraction'Image (A + B));

      elsif Op = "-" then
         Put_Line (Fraction'Image (A - B));

      elsif Op = "*" then
         Put_Line (Fraction'Image (A * B));

      elsif Op = "/" then
         Put_Line (Fraction'Image (A / B));

      elsif Op = "==" then
         Put_Line (Bool_To_Int (A = B));

      elsif Op = "!=" then
         Put_Line (Bool_To_Int (A /= B));

      elsif Op = "<" then
         Put_Line (Bool_To_Int (A < B));

      elsif Op = ">" then
         Put_Line (Bool_To_Int (A > B));

      elsif Op = "<=" then
         Put_Line (Bool_To_Int (A <= B));

      elsif Op = ">=" then
         Put_Line (Bool_To_Int (A >= B));

      end if;
   exception
      when Constraint_Error =>
         Print_Usage;
   end;
end Fraction_Math;
