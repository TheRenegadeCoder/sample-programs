divert(-1)
define(`show_usage',
`Usage: please input a number
m4exit(`1')')

dnl is_valid(n)
define(`is_valid', `eval(regexp(`$1', `^\s*-?[0-9]+\s*$') >= 0)')

dnl even_odd(n)
define(`even_odd', `ifelse(eval($1 % 2), 0, 0, 1)')
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1 || !is_valid(ARGV1)), 1, `show_usage()', dnl
`ifelse(even_odd(ARGV1), 0, `Even', `Odd')')
