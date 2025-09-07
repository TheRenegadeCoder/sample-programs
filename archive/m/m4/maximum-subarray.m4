divert(-1)
define(`show_usage',
`Usage: Please provide a list of integers in the format: "1, 2, 3, 4, 5"
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

dnl M4 does not have infinity so choose smallest integer value as minus infinity
define(`MINUS_INF', -2147483648)

dnl max(a, b)
define(`max', `ifelse(eval($1 > $2), 1, `$1', `$2')')

dnl Find maximum subarray using Kadane's algorithm.
dnl Source: https://en.wikipedia.org/wiki/Maximum_subarray_problem#No_empty_subarrays_admitted
dnl
dnl maximum_subarray(varname):
dnl   best_sum = -infinity
dnl   current_sum = 0
dnl   for n = 0 to varname[length] - 1
dnl     current_sum = varname[n] + max(0, current_sum)
dnl     best_sum = max(current_sum, best_sum)
dnl   return best_sum
define(`maximum_subarray',
`pushdef(`current_sum', 0)dnl
_maximum_subarray(`$1', 0, MINUS_INF)`'dnl
popdef(`current_sum')'dnl
)
define(`_maximum_subarray',
`ifelse(
eval($2 >= array_get(`$1', `length')), 1, `$3',
`define(`current_sum', eval(array_get(`$1', $2) + max(0, current_sum)))dnl
_maximum_subarray(`$1', incr($2), max(current_sum, $3))'`'dnl
)'dnl
)
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1 || !parse_int_list(`arr', ARGV1)), 1, `show_usage()')dnl
maximum_subarray(`arr')
