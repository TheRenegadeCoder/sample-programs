divert(-1)
define(`show_usage',
`Usage: please input a non-negative integer
m4exit(`1')')

dnl is_valid(n)
define(`is_valid', `eval(regexp(`$1', `^\s*-?[0-9]+\s*$') >= 0)')

dnl reverse(str)
define(`reverse', `ifelse(len(`$1'), 0, , `reverse(substr(`$1', 1))`'substr(`$1', 0, 1)')')

dnl is_palindrome(n)
define(`is_palindrome', `eval(`$1' == reverse(`$1'))')
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1 || !is_valid(ARGV1)), 1, `show_usage()')dnl
ifelse(eval(ARGV1 < 0), 1, `show_usage()',)dnl
ifelse(is_palindrome(ARGV1), 1, `true', `false')
