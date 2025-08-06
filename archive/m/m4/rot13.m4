divert(-1)
define(`show_usage',
`Usage: please provide a string to encrypt
m4exit(`1')')

define(`rot13', `translit(`$1', `A-MN-Za-mn-z', `N-ZA-Mn-za-m')')
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1), 1, `show_usage()', `rot13(ARGV1)')`'
