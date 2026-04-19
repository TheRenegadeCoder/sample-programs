identification division.
program-id. fizz-buzz.

data division.
working-storage section.

01 counter     pic 9(3).
01 counter-out pic z(3).

procedure division.

main.
    perform varying counter from 1 by 1 until counter > 100

        evaluate true
            when function mod(counter, 15) = 0
                display "FizzBuzz"

            when function mod(counter, 3) = 0
                display "Fizz"

            when function mod(counter, 5) = 0
                display "Buzz"

            when other
                move counter to counter-out
                display function trim(counter-out)
        end-evaluate

    end-perform

    stop run.
