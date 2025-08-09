divert(-1)
define(`show_usage',
`Usage: please provide a string
m4exit(`1')')

dnl capitalize(str)
define(`capitalize', `translit(substr(`$1', 0, 1), `a-z', `A-Z')`'substr(`$1', 1)')
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1), 1, `show_usage()', `capitalize(ARGV1)')
