: fibonacci ( n --  )
   0 1 rot 0 ?do       \ prepare the stack and loop
      tuck +           \ calculate the next fibonacci number
      i 1+ 0 .r ." : " \ print the current index
      over 0 .r cr     \ print the current fibonacci number
   loop
   2drop ;

: usage ( -- ) ." Usage: please input the count of fibonacci numbers to output" cr ;

: main
   argc @ 2 < if usage exit then
   1 arg s>number? 0= if usage exit else drop then
   fibonacci ;

main
bye
