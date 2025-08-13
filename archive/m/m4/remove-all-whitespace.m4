divert(-1)
define(`show_usage',
`Usage: please provide a string
m4exit(`1')')

define(`remove_all_whitespace', `patsubst(`$1', `\s')')
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1), 1, `show_usage()', `remove_all_whitespace(ARGV1)')
