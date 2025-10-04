: divisible
  mod 0=
;

: fizz-buzz
  dup 15 divisible if
    drop
    ." FizzBuzz"
  else
    dup 5 divisible if
      drop
      ." Buzz"
    else
      dup 3 divisible if
        drop
        ." Fizz"
      else
        .
      endif
    endif
  endif
;

: fizz-buzz-loop
  101 1 do i fizz-buzz cr loop
;

fizz-buzz-loop
bye
