identification division.
program-id. file-input-output.

environment division.
input-output section.
file-control.
    select output-file assign to "output.txt"
        organization is line sequential
        file status is ws-status.

data division.
file section.
fd output-file.
01 file-line pic x(256).

working-storage section.
01 ws-status        pic xx.
   88 file-ok       value "00".
   88 file-eof      value "10".

01 ws-message       pic x(256) value "Hello from COBOL!".
01 ws-eof-flag      pic x value "n".
   88 eof           value "y".
   88 not-eof       value "n".

procedure division.
main.
    perform write-file
    perform read-file
    stop run.

write-file.
    open output output-file

    if not file-ok
        display "Error: could not open file for writing"
        stop run
    end-if

    move ws-message to file-line
    write file-line

    close output-file.

read-file.
    open input output-file

    if not file-ok
        display "Error: could not open file for reading"
        stop run
    end-if

    set not-eof to true
    perform until eof
        read output-file
            at end
                set eof to true
            not at end
                display function trim(file-line)
        end-read
    end-perform

    close output-file.