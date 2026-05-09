with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Interfaces;       use Interfaces;

procedure Base64_Encode_Decode is

   ------------------------------------------------------------
   --  PUBLIC BASE64 API
   ------------------------------------------------------------
   package Base64 is

      -- Validate input
      procedure Validate_Input (Input : String; Is_Decode : Boolean);

      -- Encode a raw string into Base64 representation
      function Encode (Input : String) return String;

      -- Decode a Base64 string back into raw bytes
      function Decode (Input : String) return String;

      -- Raised when input is invalid (bad characters, wrong format)
      Encoding_Error : exception;

   end;

   package body Base64 is

      ------------------------------------------------------------
      --  CONSTANTS
      ------------------------------------------------------------

      -- Standard Base64 alphabet (RFC 4648)
      Alphabet : constant String :=
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

      subtype Decode_Value is Integer range -1 .. 63;

      -- Lookup table: maps ASCII characters to Base64 values
      type Decode_Table_Type is array (Character) of Decode_Value;

      Decode_Table : Decode_Table_Type := (others => -1);

      ------------------------------------------------------------
      --  INITIALIZATION
      ------------------------------------------------------------

      -- Build decode lookup table once at package initialization
      procedure Init_Table is
      begin
         for I in Alphabet'Range loop
            Decode_Table (Alphabet (I)) := I - Alphabet'First;
         end loop;
      end Init_Table;

      ------------------------------------------------------------
      --  VALIDATION
      ------------------------------------------------------------

      procedure Validate_Input (Input : String; Is_Decode : Boolean) is

         Padding_Seen : Boolean := False;

         function Is_Base64_Char (C : Character) return Boolean is
         begin
            return
              (C in 'A' .. 'Z')
              or else (C in 'a' .. 'z')
              or else (C in '0' .. '9')
              or else C = '+'
              or else C = '/'
              or else C = '=';
         end Is_Base64_Char;

      begin
         -- Fail on empty strings for both encode and decode
         if Input'Length = 0 then
            raise Encoding_Error;
         end if;

         -- If not decode, then that's the only check we'll do.
         if not Is_Decode then
            return;
         end if;

         if Input'Length mod 4 /= 0 then
            raise Encoding_Error;
         end if;

         for I in Input'Range loop

            if not Is_Base64_Char (Input (I)) then
               raise Encoding_Error;
            end if;

            -- once padding starts, everything after must be '='
            if Input (I) = '=' then
               Padding_Seen := True;
            elsif Padding_Seen then
               raise Encoding_Error;
            end if;

         end loop;
      end Validate_Input;

      ------------------------------------------------------------
      --  LOW-LEVEL HELPERS
      ------------------------------------------------------------

      -- Convert a Base64 character into its 6-bit numeric value
      -- Raises Encoding_Error if character is not valid Base64
      function To_Value (C : Character) return Unsigned_8 is
         Value : constant Integer := Decode_Table (C);
      begin
         if Value < 0 then
            raise Encoding_Error;
         end if;
         return Unsigned_8 (Value);
      end To_Value;

      -- Check whether a character is padding ('=')
      function Is_Padding (C : Character) return Boolean
      is (C = '=');

      ------------------------------------------------------------
      --  ENCODE HELPERS
      ------------------------------------------------------------

      -- Extract up to 3 bytes from input safely (zero-padded if needed)
      procedure Get_Block
        (Input : String; Index : Positive; B1, B2, B3 : out Unsigned_8) is
      begin
         B1 := Character'Pos (Input (Index));

         if Index + 1 <= Input'Last then
            B2 := Character'Pos (Input (Index + 1));
         else
            B2 := 0;
         end if;

         if Index + 2 <= Input'Last then
            B3 := Character'Pos (Input (Index + 2));
         else
            B3 := 0;
         end if;
      end Get_Block;

      -- Encode a 3-byte block into 4 Base64 characters
      -- Handles padding depending on input availability
      procedure Encode_Block
        (B1, B2, B3     : Unsigned_8;
         Has_B2, Has_B3 : Boolean;
         Result         : in out String;
         Out_Idx        : in out Positive)
      is

         T1, T2, T3, T4 : Natural;
      begin
         -- Split 24-bit block into four 6-bit chunks
         T1 := Natural (Shift_Right (B1, 2));
         T2 := Natural (Shift_Left (B1 and 3, 4) or Shift_Right (B2, 4));
         T3 := Natural (Shift_Left (B2 and 15, 2) or Shift_Right (B3, 6));
         T4 := Natural (B3 and 63);

         -- Map each chunk into Base64 alphabet
         Result (Out_Idx + 0) := Alphabet (T1 + 1);
         Result (Out_Idx + 1) := Alphabet (T2 + 1);

         -- Apply padding rules when input is incomplete
         Result (Out_Idx + 2) := (if Has_B2 then Alphabet (T3 + 1) else '=');
         Result (Out_Idx + 3) := (if Has_B3 then Alphabet (T4 + 1) else '=');

         Out_Idx := Out_Idx + 4;
      end Encode_Block;

      ------------------------------------------------------------
      --  DECODE HELPERS
      ------------------------------------------------------------

      -- Decode a single 4-character Base64 block into 1–3 bytes
      procedure Decode_Block
        (Input   : String;
         Index   : Positive;
         Out_Str : in out String;
         Out_Idx : in out Positive)
      is
         C1, C2, C3, C4 : Unsigned_8;
         B1, B2, B3     : Unsigned_8;
         Has_C3, Has_C4 : Boolean;
      begin
         C1 := To_Value (Input (Index));
         C2 := To_Value (Input (Index + 1));

         Has_C3 := not Is_Padding (Input (Index + 2));
         Has_C4 := not Is_Padding (Input (Index + 3));

         -- First byte (always)
         B1 := Shift_Left (C1, 2) or Shift_Right (C2, 4);
         Out_Str (Out_Idx) := Character'Val (B1);
         Out_Idx := Out_Idx + 1;

         -- Second byte
         if Has_C3 then
            C3 := To_Value (Input (Index + 2));
            B2 := Shift_Left (C2 and 15, 4) or Shift_Right (C3, 2);

            Out_Str (Out_Idx) := Character'Val (B2);
            Out_Idx := Out_Idx + 1;

            if Has_C4 then
               C4 := To_Value (Input (Index + 3));
               B3 := Shift_Left (C3 and 3, 6) or C4;

               Out_Str (Out_Idx) := Character'Val (B3);
               Out_Idx := Out_Idx + 1;
            end if;
         end if;
      end Decode_Block;

      ------------------------------------------------------------
      --  PUBLIC ENCODE FUNCTION
      ------------------------------------------------------------
      function Encode (Input : String) return String is
         Result  : String (1 .. ((Input'Length + 2) / 3) * 4);
         Out_Idx : Positive := Result'First;
         In_Idx  : Positive := Input'First;

         B1, B2, B3 : Unsigned_8;
      begin
         Validate_Input (Input, Is_Decode => False);

         -- Process input in 3-byte blocks
         while In_Idx <= Input'Last loop

            Get_Block (Input, In_Idx, B1, B2, B3);

            Encode_Block
              (B1,
               B2,
               B3,
               Has_B2  => (In_Idx + 1 <= Input'Last),
               Has_B3  => (In_Idx + 2 <= Input'Last),
               Result  => Result,
               Out_Idx => Out_Idx);

            In_Idx := In_Idx + 3;
         end loop;

         return Result;
      end Encode;

      ------------------------------------------------------------
      --  PUBLIC DECODE FUNCTION
      ------------------------------------------------------------
      function Decode (Input : String) return String is
         Result  : String (1 .. (Input'Length / 4) * 3);
         Out_Idx : Positive := Result'First;
         In_Idx  : Positive := Input'First;
      begin
         Validate_Input (Input, Is_Decode => True);

         -- Process input in 4-character blocks
         while In_Idx <= Input'Last loop
            Decode_Block (Input, In_Idx, Result, Out_Idx);
            In_Idx := In_Idx + 4;
         end loop;

         return Result (Result'First .. Out_Idx - 1);
      end Decode;

   begin

      -- Initialize lookup table once at package elaboration
      Init_Table;

   end Base64;

   procedure Print_Usage is
   begin
      Put_Line ("Usage: please provide a mode and a string to encode/decode");
   end Print_Usage;

begin
   if Argument_Count /= 2 then
      Print_Usage;
      Set_Exit_Status (Failure);
      return;
   end if;

   declare
      Mode : constant String := Argument (1);
      Text : constant String := Argument (2);
   begin
      if Mode = "encode" then
         Put_Line (Base64.Encode (Text));

      elsif Mode = "decode" then
         Put_Line (Base64.Decode (Text));

      else
         Print_Usage;
         Set_Exit_Status (Failure);
      end if;

   exception
      when Base64.Encoding_Error =>
         Print_Usage;
         Set_Exit_Status (Failure);
   end;

end Base64_Encode_Decode;
