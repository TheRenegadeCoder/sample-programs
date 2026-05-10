with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions;

procedure File_IO is

   File_Name : constant String := "output.txt";

   procedure Write_File is
      F : File_Type;
   begin
      Create (F, Out_File, File_Name);

      Put_Line (F, "Hello from Ada!");
      Put_Line (F, "This is a second line.");
      Put_Line (F, "File I/O is working.");

      Close (F);

   exception
      when Name_Error =>
         Put_Line ("Error: invalid file name");
      when Use_Error =>
         Put_Line ("Error: cannot create file");
   end Write_File;

   procedure Read_File is
      F : File_Type;
   begin
      Open (F, In_File, File_Name);

      while not End_Of_File (F) loop
         declare
            Line : constant String := Get_Line (F);
         begin
            Put_Line (Line);
         end;
      end loop;

      Close (F);

   exception
      when Name_Error =>
         Put_Line ("Error: file not found");
      when End_Error =>
         null;
   end Read_File;

begin
   Write_File;
   Read_File;
end File_IO;
