: even-odd ( n -- )
    2 mod 0= if
        ." Even"
    else
        ." Odd"
    then cr ;

: usage ( -- ) ." Usage: please input a number" cr ;

: main
    argc @ 2 < if usage exit then  
    1 arg s>number? 0= if usage exit else drop then
    even-odd ;

main
bye
