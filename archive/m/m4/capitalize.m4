divert(-1)
define(`show_usage',
`Usage: please provide a string
m4exit(`1')')

dnl Commas are intepreted as argument separators, so need to change them to something that
dnl won't appear in the argument and then change them back
define(`escape', `translit(``$1'', `,', `«')')
define(`unescape', `translit(``$1'', `«', `,')')

dnl capitalize(str)
define(`capitalize', `unescape(_capitalize(escape(`$1')))')
define(`_capitalize', `format(`%s%s', translit(substr(`$1', 0, 1), `a-z', `A-Z'), substr(`$1', 1))')
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1), 1, `show_usage()', `capitalize(ARGV1)')
