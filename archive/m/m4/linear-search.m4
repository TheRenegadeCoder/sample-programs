divert(-1)
define(`show_usage',
`Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")
m4exit(`1')')

dnl Reference: https://www.gnu.org/software/m4/manual/m4.html#index-array
dnl array_get(var_name, idx)
define(`array_get', `defn(format(``%s[%s]'', `$1', `$2'))')

dnl array_set(var_name, idx, value)
define(`array_set', `define(format(``%s[%s]'', `$1', `$2'), `$3')')

dnl is_valid(n)
define(`is_valid', `eval(regexp(`$1', `^\s*-?[0-9]+\s*$') >= 0)')

dnl parse_int_list(varname, args):
dnl   varname[length] = 0
dnl   foreach arg in args:
dnl     if not is_valid(arg):
dnl       Return 0
dnl     varname[varname[length]] = arg
dnl     varname[length] = varname[length] + 1
dnl   Return 1
define(`parse_int_list',
`array_set(`$1', `length', 0)dnl
_parse_int_list(`$1', $2)'dnl
)
define(`_parse_int_list',
`ifelse(is_valid(`$2'), 0, `0',
`array_set(`$1', array_get(`$1', `length'), `$2')dnl
array_set(`$1', `length', incr(array_get(`$1', `length')))dnl
ifelse(eval($# > 2), 1, `_parse_int_list(`$1', shift(shift($@)))', `1')'dnl
)'dnl
)

dnl linear_search(varname, target):
dnl   for n = 0 to varname[length] - 1
dnl     if varname[n] == target:
dnl       Return n
dnl   Return -1
define(`linear_search', `_linear_search(`$1', `$2', 0)')
define(`_linear_search',
`ifelse(
eval($3 >= array_get(`$1', `length')), 1, `-1',
array_get(`$1', $3), `$2', $3, `_linear_search(`$1', `$2', incr($3))'dnl
)'dnl
)
divert(0)dnl
ifelse(eval(ARGC < 2 || len(ARGV1) < 1 || !parse_int_list(`arr', ARGV1) || !is_valid(ARGV2)), 1, `show_usage()')dnl
ifelse(linear_search(`arr', ARGV2), -1, `false', `true')
