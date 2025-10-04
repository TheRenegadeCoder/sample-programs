divert(-1)
define(`fizzbuzz',
`ifelse(eval($1 <= $2), 1,
`ifelse(eval($1 % 15), 0, FizzBuzz,
`ifelse(eval($1 % 3), 0, Fizz,
`ifelse(eval($1 % 5), 0, Buzz, $1)')')'
`fizzbuzz(eval($1 + 1), $2)', )'dnl
)
divert(0)dnl
fizzbuzz(1, 100)dnl
