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

dnl quick_sort_rec(varname, lo, hi):
dnl   if lo >= 0 and lo < hi:
dnl     p = partition(varname, lo, hi)
dnl     quick_sort_rec(varname, lo, p-1)
dnl     quick_sort_rec(varname, p+1, hi)
define(`quick_sort_rec',
`ifelse(eval($2 >= 0 && $2 < $3), 1,
`pushdef(`p', partition(`$1', `$2', `$3'))dnl
quick_sort_rec(`$1', $2, decr(p))dnl
quick_sort_rec(`$1', incr(p), $3)dnl
popdef(`p')'dnl
)'dnl
)

dnl partition(varname, lo, hi):
dnl   // Choose the last element as the pivot
dnl   pivot = varname[hi]
dnl
dnl   // Temporary pivot index
dnl   i = lo
dnl
dnl   // Swap elements less than or equal to pivot, and increment
dnl   // temporary index
dnl   for j = lo to hi-1:
dnl     if varname[j] <= pivot:
dnl       swap(varname, i, j)
dnl       i = i + 1
dnl
dnl   // Move pivot to correct position
dnl   swap(varname, i, hi)
dnl   return i
define(`partition', `_partition(`$1', `$3', array_get(`$1', `$3'), `$2', `$2')')

dnl varname=$1, hi=$2, pivot=$3, i=$4, j=$5
define(`_partition',
`ifelse(eval($5 >= $2), 1,
`array_swap(`$1', `$4', `$2')$4',
`ifelse(eval(array_get(`$1', `$5') <= $3), 1,
`array_swap(`$1', `$4', `$5')dnl
_partition(`$1', `$2', `$3', incr($4), incr($5))',
`_partition(`$1', `$2', `$3', `$4', incr($5))'dnl
)'dnl
)'dnl
)

dnl Reference: https://en.wikipedia.org/wiki/Quicksort#Lomuto_partition_scheme
dnl quick_sort(varname):
dnl   quick_sort_rec(varname, 0, varname[length])
define(`quick_sort', `quick_sort_rec(`$1', 0, decr(array_get(`$1', `length')))')

divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1 || !parse_int_list(`arr', ARGV1)), 1, `show_usage()')dnl
ifelse(eval(array_get(`arr', `length') < 2), 1, `show_usage()')dnl
quick_sort(`arr')dnl
show_int_list(`arr')
