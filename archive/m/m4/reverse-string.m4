divert(-1)
dnl Commas are intepreted as argument separators, so need to change them to something that
dnl won't appear in the argument and then change them back
define(`escape', `translit(``$1'', `,', `«')')
define(`unescape', `translit(``$1'', `«', `,')')

dnl reverse(str)
define(`reverse', `unescape(_reverse(escape(`$1')))')
define(`_reverse', `ifelse(eval(len(`$1')), 0, , `_reverse(substr(`$1', 1))'substr(`$1', 0, 1))')
divert(0)dnl
ifelse(ARGC, 0, , `reverse(ARGV1)')
