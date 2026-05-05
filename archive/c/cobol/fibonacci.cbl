identification division.
program-id. fibonacci.

data division.
working-storage section.
01 ws-arg        pic x(100).
01 ws-n          pic 9(9) value 0.
01 ws-i          pic 9(9) value 0.

01 ws-i-disp     pic z(9).
01 ws-f-disp     pic z(18).

01 ws-f1         pic 9(18) value 1.
01 ws-f2         pic 9(18) value 1.
01 ws-fnext      pic 9(18) value 0.

procedure division.
main.
    accept ws-arg from command-line

    if ws-arg = spaces
        perform show-usage
        stop run
    end-if

    move function numval(ws-arg) to ws-n

    if ws-n = 0 and function trim(ws-arg) not = "0"
        perform show-usage
        stop run
    end-if

    if ws-n = 0
        stop run
    end-if

    display "1: 1"
    if ws-n = 1
        stop run
    end-if

    display "2: 1"

    perform varying ws-i from 3 by 1 until ws-i > ws-n
        compute ws-fnext = ws-f1 + ws-f2

        move ws-i     to ws-i-disp
        move ws-fnext to ws-f-disp

        display function trim(ws-i-disp) ": "
                function trim(ws-f-disp)

        move ws-f2    to ws-f1
        move ws-fnext to ws-f2
    end-perform

    stop run.

show-usage.
    display "Usage: please input the count of fibonacci numbers to output".