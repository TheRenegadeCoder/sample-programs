identification division.
program-id. linear-search.

data division.
working-storage section.

01 MAX-ENTRIES       constant as 100.
01 argc              binary-long.
01 list-string       pic x(1100).
01 target-string     pic x(20).
01 ws-token          pic x(20).
01 ws-ptr            binary-long.
01 num-count         binary-long value 0.
01 num-list.
   05 num            pic s9(9) 
                     occurs 1 to MAX-ENTRIES 
                     depending on num-count
                     indexed by num-idx.
01 target-number     pic s9(9).
01 search-state      pic x value 'F'.
   88 item-found     value 'T'.
   88 item-not-found value 'F'.

procedure division.

main.
    perform validate-args
    perform parse-and-validate-input
    perform linear-search
    
    if item-found
        display "true"
    else
        display "false"
    end-if
    goback.

validate-args.
    accept argc from argument-number

    if argc <> 2
        perform display-usage
    end-if

    accept list-string from argument-value
    accept target-string from argument-value
    
    if list-string = spaces or target-string = spaces
        perform display-usage
    end-if

    if function test-numval(target-string) <> 0
        perform display-usage
    end-if
    
    move function numval(target-string) to target-number.

parse-and-validate-input.
    move 1 to ws-ptr
    perform until ws-ptr > length of list-string 
               or list-string(ws-ptr:) = spaces

        move spaces to ws-token
        unstring list-string
            delimited by all ","
            into ws-token
            with pointer ws-ptr
        end-unstring

        if ws-token <> spaces
            if function test-numval(ws-token) <> 0
                perform display-usage
            end-if

            add 1 to num-count
            if num-count > MAX-ENTRIES
                perform display-usage
            end-if

            move function numval(ws-token) to num(num-count)
        end-if
    end-perform

    if num-count = 0
        perform display-usage
    end-if.

linear-search.
    set item-not-found to true
    search num
        when num(num-idx) = target-number
            set item-found to true
    end-search.

display-usage.
    display 'Usage: please provide a list of integers ' 
            '("1, 4, 5, 11, 12") and the integer to find ("11")'
    stop run.
