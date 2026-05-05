identification division.
program-id. longest-word.

data division.
working-storage section.

01 ws-input        pic x(200).
01 ws-temp         pic x(200).
01 ws-pos          pic 9(4) value 1.

01 ws-word-len     pic 9(4) value 0.
01 ws-max-len      pic 9(4) value 0.

01 ws-char         pic x.

01 ws-valid        pic x value "y".
   88 is-valid     value "y".
   88 is-invalid   value "n".
01 ws-out-num      pic -(9)9.

procedure division.

main.
    accept ws-input from argument-value

    if ws-input = spaces
        perform show-usage
        stop run
    end-if

    perform compute-max
    
    move ws-max-len to ws-out-num
    display function trim(ws-out-num)
    stop run.


compute-max.
    move 1 to ws-pos
    move 0 to ws-word-len
    move 0 to ws-max-len

    perform until ws-pos > function length(function trim(ws-input))

        move ws-input(ws-pos:1) to ws-char

        if ws-char = " " or ws-char = x"09" or ws-char = x"0A" or ws-char = x"0D"
            compute ws-max-len = function max(ws-word-len, ws-max-len)
            move 0 to ws-word-len
        else
            add 1 to ws-word-len
        end-if

        add 1 to ws-pos

    end-perform

    if ws-word-len > ws-max-len
        move ws-word-len to ws-max-len
    end-if.


show-usage.
    display "Usage: please provide a string".