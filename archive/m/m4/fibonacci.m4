divert(-1)
define(`show_usage',
`Usage: please input the count of fibonacci numbers to output
m4exit(`1')')

dnl is_valid(n)
define(`is_valid', `eval(regexp(`$1', `^\s*-?[0-9]+\s*$') >= 0)')

dnl fibonacci(n)
define(`fibonacci',
`ifelse(`$#', 0, ``$0'',
`ifelse(eval(`$1' >= 1), 1, `_fibonacci(`$1', 1, 0, 1)')'dnl
)'dnl
)
dnl _fibonacci(n, k, prev_state, curr_state)
dnl while k <= n:
dnl   Output k ": " curr_state
dnl   prev_state, curr_state = curr_state, prev_state + curr_state
dnl   k = k + 1
define(`_fibonacci',
`ifelse(eval(`$2' <= `$1'), 1,
`$2: $4
_fibonacci(`$1', incr($2), `$4', `eval($3 + $4)')dnl
')')
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1 || !is_valid(ARGV1)), 1, `show_usage()', `fibonacci(ARGV1)')dnl
