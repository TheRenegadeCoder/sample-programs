identification division.
program-id. maximum-subarray.

data division.
working-storage section.

01 ws-input        pic x(200).
01 ws-temp         pic x(200).
01 ws-pos          pic 9(4) value 1.

01 ws-n            pic 9(4) value 0.
01 ws-i            pic 9(4).

01 ws-num          pic s9(9).

01 ws-arr occurs 100 times pic s9(9).

01 ws-current-sum  pic s9(18) value 0.
01 ws-max-sum      pic s9(18) value 0.

01 ws-has-negative pic x value "n".
   88 has-negative  value "y".
   88 no-negative   value "n".

01 ws-out          pic -(9)9.

procedure division.
main.
    accept ws-input from argument-value

    if ws-input = spaces
        perform show-usage
        stop run
    end-if

    perform parse-input

    if ws-n < 1
        perform show-usage
        stop run
    end-if

    perform check-negatives
    perform compute-kadane

    move ws-max-sum to ws-out
    display function trim(ws-out)
    stop run.

parse-input.
    move 0 to ws-n
    move 1 to ws-pos
    move ws-input to ws-temp

    perform until ws-pos > function length(function trim(ws-temp))

        unstring ws-temp
            delimited by ","
            into ws-num
            with pointer ws-pos
        end-unstring

        add 1 to ws-n
        move ws-num to ws-arr(ws-n)

    end-perform.

check-negatives.
    set no-negative to true

    perform varying ws-i from 1 by 1 until ws-i > ws-n
        if ws-arr(ws-i) < 0
            set has-negative to true
        end-if
    end-perform.


compute-kadane.
    move ws-arr(1) to ws-current-sum
    move ws-arr(1) to ws-max-sum

    perform varying ws-i from 2 by 1 until ws-i > ws-n

        if ws-current-sum + ws-arr(ws-i) > ws-arr(ws-i)
            add ws-arr(ws-i) to ws-current-sum
        else
            move ws-arr(ws-i) to ws-current-sum
        end-if

        if ws-current-sum > ws-max-sum
            move ws-current-sum to ws-max-sum
        end-if

    end-perform

    if no-negative
        move 0 to ws-max-sum
        perform varying ws-i from 1 by 1 until ws-i > ws-n
            add ws-arr(ws-i) to ws-max-sum
        end-perform
    end-if.

show-usage.
    display 'Usage: Please provide a list of integers in the format: "1, 2, 3, 4, 5"'.