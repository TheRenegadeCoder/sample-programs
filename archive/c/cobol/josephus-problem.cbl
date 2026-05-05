identification division.
program-id. josephus-problem.

data division.
working-storage section.

01 ws-n              pic 9(9).
01 ws-k              pic 9(9).

01 ws-arg-n          pic x(50).
01 ws-arg-k          pic x(50).

01 ws-survivor       pic 9(9) value 0.
01 ws-i              pic 9(9).

01 ws-n-num          pic 9(9) value 0.
01 ws-k-num          pic 9(9) value 0.

01 ws-valid          pic x value "y".
   88 is-valid       value "y".
   88 is-invalid     value "n".
01 ws-out            pic -(11)9.
01 ws-temp-sum       pic 9(9) value 0.
01 ws-quotient       pic 9(9) value 0.

procedure division.

main.
    accept ws-arg-n from argument-value
    accept ws-arg-k from argument-value

    if ws-arg-n = spaces or ws-arg-k = spaces
        perform show-usage
        stop run
    end-if

    move function numval(ws-arg-n) to ws-n-num
    move function numval(ws-arg-k) to ws-k-num

    if ws-n-num = 0 or ws-k-num = 0
        perform show-usage
        stop run
    end-if

    perform compute-josephus

    add 1 to ws-survivor
    move ws-survivor to ws-out
    display function trim(ws-out)

    stop run.

compute-josephus.
    move 0 to ws-survivor

    perform varying ws-i from 1 by 1 until ws-i > ws-n-num
        add ws-survivor to ws-k-num giving ws-temp-sum
        divide ws-i into ws-temp-sum giving ws-quotient remainder ws-survivor
    end-perform.

show-usage.
    display "Usage: please input the total number of people and number of people to skip."