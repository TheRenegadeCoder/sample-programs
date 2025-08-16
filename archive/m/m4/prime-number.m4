divert(-1)
define(`show_usage',
`Usage: please input a non-negative integer
m4exit(`1')')

dnl is_valid(n)
define(`is_valid', `eval(regexp(`$1', `^\s*-?[0-9]+\s*$') >= 0)')

dnl is_prime(n)
dnl if n < 2 or (n > 2 and (n % 2) == 0):
dnl   Output "0"
dnl else:
dnl   k = 3
dnl   loop:
dnl     if k * k > n:
dnl       Output "1" and return
dnl     if n % k == 0:
dnl       Output "0" and return
dnl     k = k + 2
define(`is_prime',
`ifelse(eval(`$1' < 2 || (`$1' > 2 && `$1' % 2 == 0)), 1, `0', `_is_prime(`$1', 3)')'dnl
)
define(`_is_prime',
`ifelse(eval(`$2' * `$2' > `$1'), 1, `1', eval(`$1' % `$2'), 0, `0', `_is_prime(`$1', eval(`$2' + 2))')'dnl
)
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1 || !is_valid(ARGV1)), 1, `show_usage()')dnl
ifelse(eval(ARGV1 < 0), 1, `show_usage()')dnl
ifelse(is_prime(ARGV1), 1, `prime', `composite')
