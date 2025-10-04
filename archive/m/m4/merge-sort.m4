divert(-1)
define(`show_usage',
`Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"
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

dnl Reference: https://en.wikipedia.org/wiki/Merge_sort#Top-down_implementation
dnl merge_sort(varnameA, varnameB):
dnl   copy(varnameA, varnameB)
dnl   merge_sort_rec(varnameA, 0, varnameA[length], varnameB)
define(`merge_sort',
`copy(`$1', `$2')dnl
merge_sort_rec(`$1', 0, array_get(`$1', `length'), `$2')'dnl
)

dnl copy(varnameA, varnameB):
dnl   n = varnameA[length]
dnl   varnameB[length] = n
dnl   for i = 0 to n-1:
dnl     varnameB[i] = varnameA[i]
define(`copy',
`array_set(`$2', `length', array_get(`$1', `length'))dnl
_copy(`$1', `$2', 0)'dnl
)
define(`_copy',
`ifelse(eval($3 < array_get(`$1', `length')), 1,
`array_set(`$2', $3, array_get(`$1', $3))dnl
_copy(`$1', `$2', incr($3))'dnl
)'dnl
)

dnl varnameB=$1, iBegin=$2, iEnd=$3, varnameA=$4
dnl merge_sort_rec(varnameB, iBegin, iEnd, varnameA):
dnl   if iEnd - iBegin > 1:
dnl     iMid = (iBegin + iEnd) / 2
dnl
dnl     // Sort left side of varnameA into varnameB
dnl     merge_sort_rec(varnameA, iBegin, iMid, varnameB)
dnl
dnl     // Sort right side of varnameA into varnameB
dnl     merge_sort_rec(varnameA, iMid, iEnd, varnameB)
dnl
dnl     // Merge varnameB into varnameA
dnl     merge(varnameB, iBegin, iMid, iEnd, varnameA)
define(`merge_sort_rec',
`ifelse(eval($3 - $2 > 1), 1,
`pushdef(`iMid', eval(($2 + $3) >> 1))dnl
merge_sort_rec(`$4', `$2', iMid, `$1')dnl
merge_sort_rec(`$4', iMid, `$3', `$1')dnl
merge(`$1', `$2', iMid, `$3', `$4')dnl
popdef(`iMid')'dnl
)'dnl
)

dnl varnameB=$1, iBegin=$2, iMid=$3, iEnd=$4, varnameA=$5
dnl merge(varnameB, iBegin, iMid, iEnd, varnameA):
dnl   i = iBegin
dnl   j = iMid
dnl   for k = iBegin to iEnd-1:
dnl     if i < iMid and j >= iEnd:
dnl       varnameB[k] = varnameA[i]
dnl       i = i + 1
dnl     else:
dnl       // Cannot combine this with previous if due to how m4 expands macros
dnl       if i < iMid and varnameA[i] <= varnameA[j]:
dnl         varnameB[k] = varnameA[i]
dnl         i = i + 1
dnl       else:
dnl         varnameB[k] = varnameA[j]
dnl         j = j + 1
define(`merge', `_merge(`$1', `$2', `$3', `$4', `$5', `$2', `$3', `$2')')

dnl varnameB=$1, iBegin=$2, iMid=$3, iEnd=$4, varnameA=$5, i=$6, j=$7, k=$8
define(`_merge',
`ifelse(eval($8 < $4), 1,
`ifelse(eval($6 < $3 && $7 >= $4), 1,
`array_set(`$1', `$8', array_get(`$5', `$6'))dnl
_merge(`$1', `$2', `$3', `$4', `$5', incr($6), `$7', incr($8))',
`ifelse(eval($6 < $3 && array_get(`$5', `$6') <= array_get(`$5', `$7')), 1,
`array_set(`$1', `$8', array_get(`$5', `$6'))dnl
_merge(`$1', `$2', `$3', `$4', `$5', incr($6), `$7', incr($8))',
`array_set(`$1', `$8', array_get(`$5', `$7'))dnl
_merge(`$1', `$2', `$3', `$4', `$5', `$6', incr($7), incr($8))'dnl
)'dnl
)'dnl
)'dnl
)

divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1 || !parse_int_list(`arrA', ARGV1)), 1, `show_usage()')dnl
ifelse(eval(array_get(`arrA', `length') < 2), 1, `show_usage()')dnl
merge_sort(`arrA', `arrB')dnl
show_int_list(`arrA')
