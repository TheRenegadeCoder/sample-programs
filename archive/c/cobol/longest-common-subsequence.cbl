identification division.
program-id. longest-common-subsequence.

environment division.

data division.
working-storage section.

01 ws-a-line            pic x(200).
01 ws-b-line            pic x(200).

01 ws-a occurs 50 times pic s9(9).
01 ws-b occurs 50 times pic s9(9).

01 ws-a-count           pic 9(4) value 0.
01 ws-b-count           pic 9(4) value 0.

01 ws-i                 pic 9(4).
01 ws-j                 pic 9(4).
01 ws-pos               pic 9(4).

01 ws-temp              pic x(200).
01 ws-num               pic s9(9).

01 dp-table.
   05 dp-row occurs 51 times.
      10 dp-col occurs 51 times pic 9(9) value 0.

01 ws-result occurs 50 times pic s9(9).
01 ws-result-len        pic 9(4) value 0.
01 ws-out-num           pic -(9)9.

01 ws-valid             pic x value "y".
   88 is-valid             value "y".
   88 is-invalid           value "n".

procedure division.
main.
    accept ws-a-line from argument-value
    accept ws-b-line from argument-value

    if ws-a-line = spaces or ws-b-line = spaces
        perform show-usage
        stop run
    end-if

    perform parse-input

    if is-invalid
        perform show-usage
        stop run
    end-if

    perform build-dp
    perform backtrack

    perform print-result
    stop run.

parse-input.
    set is-valid to true

    move ws-a-line to ws-temp
    perform parse-a

    move ws-b-line to ws-temp
    perform parse-b

    if ws-a-count = 0 or ws-b-count = 0
        set is-invalid to true
    end-if.

parse-a.
    move 0 to ws-a-count
    move 1 to ws-pos

    perform until ws-pos > length of ws-temp
        unstring ws-temp
            delimited by ","
            into ws-num
            with pointer ws-pos
        end-unstring

        add 1 to ws-a-count
        move ws-num to ws-a(ws-a-count)
    end-perform.

parse-b.
    move 0 to ws-b-count
    move 1 to ws-pos

    perform until ws-pos > length of ws-temp
        unstring ws-temp
            delimited by ","
            into ws-num
            with pointer ws-pos
        end-unstring

        add 1 to ws-b-count
        move ws-num to ws-b(ws-b-count)
    end-perform.

build-dp.
    perform varying ws-i from 0 by 1 until ws-i > ws-a-count
        perform varying ws-j from 0 by 1 until ws-j > ws-b-count
            move 0 to dp-col(ws-i + 1, ws-j + 1)
        end-perform
    end-perform

    perform varying ws-i from 1 by 1 until ws-i > ws-a-count
        perform varying ws-j from 1 by 1 until ws-j > ws-b-count

            if ws-a(ws-i) = ws-b(ws-j)
                compute dp-col(ws-i + 1, ws-j + 1) =
                    dp-col(ws-i, ws-j) + 1
            else
                compute dp-col(ws-i + 1, ws-j + 1) = 
                    function max(dp-col(ws-i, ws-j + 1), dp-col(ws-i + 1, ws-j))
            end-if

        end-perform
    end-perform.

backtrack.
    move ws-a-count to ws-i
    move ws-b-count to ws-j
    move 0 to ws-result-len

    perform until ws-i = 0 or ws-j = 0

        if ws-a(ws-i) = ws-b(ws-j)
            add 1 to ws-result-len
            move ws-a(ws-i) to ws-result(ws-result-len)

            subtract 1 from ws-i
            subtract 1 from ws-j
        else
            if dp-col(ws-i, ws-j + 1) >= dp-col(ws-i + 1, ws-j)
                subtract 1 from ws-i
            else
                subtract 1 from ws-j
            end-if
        end-if

    end-perform.

print-result.
    if ws-result-len = 0
        display spaces
        exit paragraph
    end-if

    perform varying ws-i from ws-result-len by -1 until ws-i = 0
        move ws-result(ws-i) to ws-out-num
        display function trim(ws-out-num) with no advancing

        if ws-i > 1
            display ", " with no advancing
        end-if
    end-perform.

show-usage.
    display 'Usage: please provide two lists in the format "1, 2, 3, 4, 5"'.
