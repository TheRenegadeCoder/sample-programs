divert(-1)
define(`show_usage',
`Usage: please provide a string
m4exit(`1')')

dnl Commas are intepreted as argument separators, so need to change them to something that
dnl won't appear in the argument
define(`escape', `translit(``$1'', `,', `«')')

dnl max(a, b)
define(`max', `ifelse(eval(`$1' > `$2'), 1, `$1', `$2')')

dnl longest_word(str)
define(`longest_word', `_longest_word(escape(`$1'), 0, 0)')

dnl _longest_word(str, curr_len, max_len)
dnl for each character in str (ch):
dnl   if ch is whitespace:
dnl     curr_len = 0
dnl   else:
dnl     curr_len = curr_len + 1
dnl     max_len = max(curr_len, max_len)
dnl Return max_len
define(`_longest_word',
`ifelse(len(`$1'), 0, `$3',
regexp(substr(`$1', 0, 1), `\s'), 0,
`_longest_word(substr(`$1', 1), 0, `$3')',
`_longest_word(substr(`$1', 1), incr(`$2'), max(incr(`$2'), `$3'))'dnl
)'dnl
)
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1), 1, `show_usage()', `longest_word(ARGV1)')
