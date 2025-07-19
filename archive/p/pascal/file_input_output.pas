program FileIO;

{$mode objfpc}{$H+}

uses
   SysUtils;

const
   DefaultFileName = 'output.txt';

function WriteToFile(const FileName: string): integer;
var
   F: TextFile;
begin
   Result := 1; // failure by default
   try
      AssignFile(F, FileName);
      Rewrite(F);

      try
         Writeln(F, 'A line of text');
         Writeln(F, 'Another line of text');
         Result := 0; // success
      finally
         CloseFile(F);
      end;
   except
      on E: Exception do
      begin
         Writeln('Error writing to file "', FileName, '": ', E.Message);
      end;
   end;
end;

function ReadFromFile(const FileName: string): integer;
var
   F: TextFile;
   Line: string;
   LinesRead: integer;
begin
   Result := 1; // failure by default
   LinesRead := 0;
   try
      AssignFile(F, FileName);
      Reset(F);

      try
         while not EOF(F) do
         begin
            ReadLn(F, Line);
            Writeln(Line);
            Inc(LinesRead);
         end;
         if LinesRead = 0 then
            Writeln('(File "', FileName, '" is empty)');
         Result := 0; // success
      finally
         CloseFile(F);
      end;
   except
      on E: Exception do
      begin
         Writeln('Error reading from file "', FileName, '": ', E.Message);
      end;
   end;
end;

var
   FileName: string;
begin
   FileName := DefaultFileName;

   if WriteToFile(FileName) <> 0 then
   begin
      ExitCode := 1;
      Exit;
   end;

   if ReadFromFile(FileName) <> 0 then
   begin
      ExitCode := 1;
      Exit;
   end;

   ExitCode := 0;
end.

