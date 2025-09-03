divert(-1)
define(`show_usage',
`Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")
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

dnl is_sorted(varname):
dnl   if varname[length] < 2:
dnl     Return 1
dnl   for n = 1 to varname[length] - 1:
dnl     if varname[n - 1] > varname[n]:
dnl       Return 0
dnl   Return 1
define(`is_sorted', `ifelse(eval(array_get(`$1', `length') < 2), 1, `1', `_is_sorted(`$1', 1)')')
define(`_is_sorted',
`ifelse(
eval(incr($2) >= array_get(`$1', `length')), 1, `1',
eval(array_get(`$1', decr($2)) > array_get(`$1', $2)), 1, `0',
`_is_sorted(`$1', incr($2))'dnl
)'dnl
)

dnl binary_search(varname, target):
dnl   lo = 0
dnl   hi = varname[length]
dnl   while lo < hi:
dnl     mid = (lo + hi) // 2
dnl     if varname[mid] == target:
dnl       Return mid
dnl     elseif varname[mid] < target:
dnl       lo = mid + 1
dnl     else:
dnl       hi = mid
dnl   Return -1
define(`binary_search',
`pushdef(`mid', `')dnl
_binary_search(`$1', 0, array_get(`$1', `length'), $2)dnl
popdef(`mid')'dnl
)
define(`_binary_search',
`ifelse(
eval($2 >= $3), 1, `-1',
`define(`mid', eval(($2 + $3) / 2))dnl
ifelse(
array_get(`$1', mid), $4, mid,
eval(array_get(`$1', mid) < $4), 1, `_binary_search(`$1', incr(mid), $3, $4)',
`_binary_search(`$1', $2, mid, $4)'dnl
)'dnl
)'dnl
)

divert(0)dnl
ifelse(eval(ARGC < 2 || len(ARGV1) < 1 || !parse_int_list(`arr', ARGV1) || !is_valid(ARGV2)), 1, `show_usage()')dnl
ifelse(is_sorted(`arr'), 0, `show_usage()')dnl
ifelse(binary_search(`arr', ARGV2), -1, `false', `true')
