identification division.
program-id. fraction-math.

data division.
working-storage section.

01 ws-arguments.
    05 ws-arg1              pic x(50).
    05 ws-arg2              pic x(50).
    05 ws-op                pic x(2).

01 ws-fractions.
    05 ws-f1.
        10 ws-n1             pic s9(18).
        10 ws-d1             pic s9(18).
    05 ws-f2.
        10 ws-n2             pic s9(18).
        10 ws-d2             pic s9(18).
    05 ws-result.
        10 ws-rn             pic s9(18).
        10 ws-rd             pic s9(18).

01 ws-flags.
    05 ws-valid-flag         pic x value 'y'.
        88 is-valid                value 'y'.
        88 is-invalid              value 'n'.

01 ws-work-areas.
    05 ws-temp-fraction     pic x(50).
    05 ws-pos               pic 9(4).
    05 ws-gcd-vars.
        10 ws-a             pic s9(18).
        10 ws-b             pic s9(18).
        10 ws-rem           pic s9(18).
    05 ws-cross-prod-1      pic s9(36).
    05 ws-cross-prod-2      pic s9(36).

01 ws-display-fields.
    05 ws-out-n             pic -(18)9.
    05 ws-out-d             pic -(18)9.

procedure division.
000-main.
    accept ws-arg1 from argument-value
    accept ws-op   from argument-value
    accept ws-arg2 from argument-value

    if ws-arg1 = spaces or ws-op = spaces or ws-arg2 = spaces
        perform show-usage
        stop run
    end-if

    move ws-arg1 to ws-temp-fraction
    perform parse-fraction
    move ws-rn to ws-n1
    move ws-rd to ws-d1

    if is-valid
        move ws-arg2 to ws-temp-fraction
        perform parse-fraction
        move ws-rn to ws-n2
        move ws-rd to ws-d2
    end-if

    if is-invalid
        perform show-usage
        stop run
    end-if

    perform calculate-result
    stop run.

parse-fraction.
    set is-valid to true
    move 0 to ws-pos
    inspect ws-temp-fraction tallying ws-pos for characters before "/"
    
    if ws-pos = 0 or ws-pos = length of ws-temp-fraction
        set is-invalid to true
    else
        move function numval(ws-temp-fraction(1:ws-pos)) to ws-rn
        move function numval(ws-temp-fraction(ws-pos + 2:)) to ws-rd
        if ws-rd = 0
            set is-invalid to true
        end-if
    end-if.

calculate-result.
    evaluate ws-op
        when "+"
            compute ws-rn = ws-n1 * ws-d2 + ws-n2 * ws-d1
            compute ws-rd = ws-d1 * ws-d2
            perform reduce-and-print
        when "-"
            compute ws-rn = ws-n1 * ws-d2 - ws-n2 * ws-d1
            compute ws-rd = ws-d1 * ws-d2
            perform reduce-and-print
        when "*"
            multiply ws-n1 by ws-n2 giving ws-rn
            multiply ws-d1 by ws-d2 giving ws-rd
            perform reduce-and-print
        when "/"
            multiply ws-n1 by ws-d2 giving ws-rn
            multiply ws-d1 by ws-n2 giving ws-rd
            perform reduce-and-print
        when "==" when "!=" when ">" when "<" when ">=" when "<="
            perform compare-fractions
        when other
            perform show-usage
    end-evaluate.

reduce-and-print.
    if ws-rn = 0
        move 1 to ws-rd
    else
        move function abs(ws-rn) to ws-a
        move function abs(ws-rd) to ws-b
        perform until ws-b = 0
            divide ws-a by ws-b giving ws-a remainder ws-rem
            move ws-b to ws-a
            move ws-rem to ws-b
        end-perform
        divide ws-a into ws-rn
        divide ws-a into ws-rd
    end-if

    if ws-rd < 0
        multiply -1 by ws-rn
        multiply -1 by ws-rd
    end-if

    move ws-rn to ws-out-n
    move ws-rd to ws-out-d
    display function trim(ws-out-n) "/" function trim(ws-out-d).

compare-fractions.
    compute ws-cross-prod-1 = ws-n1 * ws-d2
    compute ws-cross-prod-2 = ws-n2 * ws-d1
    
    evaluate true
        when ws-op = "==" and ws-cross-prod-1  = ws-cross-prod-2
        when ws-op = "!=" and ws-cross-prod-1 not = ws-cross-prod-2
        when ws-op = ">"  and ws-cross-prod-1  > ws-cross-prod-2
        when ws-op = "<"  and ws-cross-prod-1  < ws-cross-prod-2
        when ws-op = ">=" and ws-cross-prod-1 >= ws-cross-prod-2
        when ws-op = "<=" and ws-cross-prod-1 <= ws-cross-prod-2
            display "1"
        when other
            display "0"
    end-evaluate.

show-usage.
    display "Usage: ./fraction-math operand1 operator operand2".