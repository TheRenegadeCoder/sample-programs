USING: io kernel math prettyprint ranges sequences ;
IN: baklava

! Based on https://rosettacode.org/wiki/Repeat_a_string#Factor
! but reversed arguments for fewer operations
: repeat-string ( n str -- str' ) <repetition> concat ;

: baklava-line ( n -- str )
    10 - abs        ! stack: num-spaces = abs(n - 10)
    dup             ! stack: num-spaces, num-spaces
    " "             ! stack: num-spaces, num-spaces, " "
    repeat-string   ! stack: num-spaces, spaces = " " num-spaces times
    swap            ! stack: spaces, num-spaces
    -2 * 21 +       ! stack: spaces, num-stars = 21 - 2 * num-spaces
    "*"             ! stack: spaces, num-stars, "*"
    repeat-string   ! stack: spaces, stars = "*" num-stars times
    append          ! stack: spaces + stars
    ;

! For n = 0 to 20, output Baklava line n
20 [0..b] [ baklava-line print ] each
