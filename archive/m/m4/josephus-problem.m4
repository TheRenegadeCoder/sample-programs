divert(-1)
define(`show_usage',
`Usage: please input the total number of people and number of people to skip.
m4exit(`1')')

dnl is_valid(n)
define(`is_valid', `eval(regexp(`$1', `^\s*-?[0-9]+\s*$') >= 0)')

dnl josephus_problem(n, k)
dnl Reference: https://en.wikipedia.org/wiki/Josephus_problem#The_general_case
dnl
dnl Use zero-based index algorithm:
dnl
dnl     g(1, k) = 0
dnl     g(m, k) = [g(m - 1, k) + k] MOD m, for m = 2, 3, ..., n
dnl
dnl Final answer is g(n, k) + 1 to get back to one-based index
define(`josephus_problem', `_josephus_problem(`$1', `$2', 0, 2)')

dnl _josephus_problem(n, k, g, m)
dnl while m <= n:
dnl   g = (g + k) % m
dnl   m = m + 1
dnl Return g + 1
define(`_josephus_problem',
`ifelse(eval(`$4' <= `$1'), 1,
    `_josephus_problem(`$1', `$2', eval((`$3' + `$2') % `$4'), incr(`$4'))',
    incr(`$3')dnl
)'dnl
)
divert(0)dnl
ifelse(eval(ARGC < 2 || !is_valid(ARGV1) || !is_valid(ARGV2)), 1,
    `show_usage()', `josephus_problem(ARGV1, ARGV2)')
