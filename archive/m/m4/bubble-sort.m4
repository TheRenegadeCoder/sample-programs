divert(-1)
define(`show_usage',
`Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"
m4exit(`1')')

dnl Reference: https://www.gnu.org/software/m4/manual/m4.html#index-array
dnl array_get(var_name, idx)
define(`array_get', `defn(format(``%s[%s]'', `$1', `$2'))')

dnl array_set(var_name, idx, value)
define(`array_set', `define(format(``%s[%s]'', `$1', `$2'), `$3')')

dnl array_swap(var_name, idx1, idx2):
dnl   t = var_name[idx1]
dnl   var_name[idx1] = var_name[idx2]
dnl   var_name[idx] = t
define(`array_swap',
`pushdef(`t', array_get(`$1', `$2'))dnl
array_set(`$1', `$2', array_get(`$1', `$3'))dnl
array_set(`$1', `$3', t)dnl
popdef(`t')'dnl
)

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

dnl show_int_list(varname):
dnl   for i = 0 to n-1:
dnl      if i > 0:
dnl        Output ", "
dnl      Output varname[i]
define(`show_int_list', `_show_int_list(`$1', 0)')
define(`_show_int_list',
`ifelse(eval($2 < array_get(`$1', `length')), 1,
`ifelse(eval($2 > 0), 1, `, ')dnl
array_get(`$1', $2)`'dnl
_show_int_list(`$1', incr($2))'`'dnl
)'dnl
)

dnl Reference: https://en.wikipedia.org/wiki/Bubble_sort#Pseudocode_implementation
dnl bubble_sort(varname):
dnl   n = varname[length]
dnl   do:
dnl     swapped = false
dnl     for i from 1 to n-1:
dnl       if varname[i-1] > varname[i]:
dnl         swap(varname, i-1, i)
dnl         swapped = true
dnl   while swapped
define(`bubble_sort', `ifelse(_bubble_sort_outer(`$1', 1, 0), 1, `bubble_sort(`$1')')')
define(`_bubble_sort_outer',
`ifelse(eval($2 < array_get(`$1', `length')), 0,
`$3',
`ifelse(_bubble_sort_inner(`$1', $2), 1,
`_bubble_sort_outer(`$1', incr($2), 1)', `_bubble_sort_outer(`$1', incr($2), $3)'dnl
)'dnl
)'dnl
)
define(`_bubble_sort_inner',
`ifelse(eval(array_get(`$1', decr($2)) <= array_get(`$1', $2)), 1,
0, `array_swap(`$1', decr($2), $2)1'`'dnl
)'dnl
)

divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1 || !parse_int_list(`arr', ARGV1)), 1, `show_usage()')dnl
ifelse(eval(array_get(`arr', `length') < 2), 1, `show_usage()')dnl
bubble_sort(`arr')dnl
show_int_list(`arr')
