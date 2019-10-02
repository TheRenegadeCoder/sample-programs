-- RFC4180 https://tools.ietf.org/html/rfc4180

package body CSV is

    --
    -- Return the size of the CSV record. This function just returns the length
    -- of the container (vector).
    -- @param rec CSV record
    -- @return Size of the record, in columns
    --
    function Size(rec: in CSV_Record) return Natural is
    begin
        return Natural(Length(rec));
    end Size;

    --
    -- Retrieve the CSV record value at the given index. If the given index falls
    -- outside of the range of available columns then a Constraint_Error will be
    -- raised.
    -- @param rec CSV record
    -- @param index Column index
    -- @return CSV column value
    --
    function Get(rec: in CSV_Record;
               index: in Natural) return String is
    begin
        if index > 0 and index <= Size(rec) then
            return To_String(rec.Element(index));
        end if;
        raise Constraint_Error;
    end Get;

    --
    -- Update the CSV element at the given column index with the supplied value.
    -- If the given index falls outside of the range of available columns then
    -- a Constraint_Error will be raised.
    -- @param rec CSV record
    -- @param index Column index
    -- @param value New column value
    --
    procedure Set(rec: in out CSV_Record;
                index: in Natural;
                value: in String) is
    begin
        if index > 0 and index <= Size(rec) then
            rec.Replace_Element(index, To_Unbounded_String(value));
        else
            raise Constraint_Error;
        end if;
    end Set;

    --
    -- Parse the given line into its components and return a vector of strings that represent
    -- the desired contents of the columns. The CSV file is passed in as an argument since a
    -- line CAN span multiple lines of input (RFC4180).
    -- @param csv CSV file
    -- @return Vector of strings
    --
    function Parse(csv: in out CSV_File; raw: in String) return CSV_Record is
        rec:   CSV_Record;
        index: Natural := raw'First;
    begin
        return rec;
    end Parse;

    --
    -- Open the CSV file for reading and/or writing. 
    -- @param csv CSV object
    -- @param file_name Name of the CSV file
    -- @param mode File mode (In_File, Out_File, or In_Out_File)
    -- @param delimiter Default delimiter
    -- @param has_header True if this CSV file has a header line
    --
    procedure Open(csv: in out CSV_File;
             file_name: in String;
                  mode: in Ada.Text_IO.File_Mode := Ada.Text_IO.In_File;
             delimiter: in String := ",";
            has_header: in Boolean := false) is
    begin
        Ada.Text_IO.Open(csv.file, mode, file_name);
        csv.delim := delimiter(delimiter'First);
        if has_header then
            null; -- csv.header := Parse(csv, 
        end if;
    end Open;

    --
    -- Close the CSV file.
    -- @param csv CSV file
    --
    procedure Close(csv: in out CSV_File) is
    begin
        Ada.Text_IO.Close(csv.file);
    end Close;

    --
    -- Return the column index for the named column. IF the named column does
    -- not exist in the headers then a Contraint_Error will be thrown.
    -- @param csv CSV File
    -- @param column_name Name of column to look up
    -- @return Index of the named column
    --
    function Column_Index(csv: in CSV_File;
                  column_name: in String) return Natural is
        uname: Unbounded_String := To_Unbounded_String(column_name);
    begin
        if csv.headers.Contains(uname) then
            return Natural(csv.headers.Find_Index(uname));
        end if;
        raise Constraint_Error;
    end Column_Index;

    --
    -- Read the next line from the CSV file. If there are no more lines in the
    -- file to read then an End_Error will be raised.
    -- @param csv CSV File
    -- @param delimiter Delimiter override (supercedes the CSV file object)
    -- @return CSV_Record
    --
    function Read(csv: in CSV_File'Class;
            delimiter: in String := ",") return CSV_Record is
        rec: CSV_Record;
    begin
        return rec;
    end Read;

    --
    -- Write the given CSV record into the provede CSV file using the delimiter
    -- specified. If the use_quotes is set to True then all columns will be
    -- emitted surrounded by double quotes and all quotes inside those columns
    -- will be escaped (by double-quoting the double-quotes).
    -- @param csv CSV File
    -- @param rec CSV Record
    -- @param delimiter Column delimiter
    -- @param use_quotes Force column quotes
    --
    procedure Write(csv: in CSV_File'Class;
                    rec: in CSV_Record;
              delimiter: in String := ",";
             use_quotes: in Boolean := True) is
    begin
        null;
    end Write;

end CSV;

