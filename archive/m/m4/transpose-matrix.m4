divert(-1)
define(`show_usage',
`Usage: please enter the dimension of the matrix and the serialized matrix
m4exit(`1')')

dnl Reference: https://www.gnu.org/software/m4/manual/m4.html#index-array
dnl array_get(varname, idx)
define(`array_get', `defn(format(``%s[%s]'', `$1', `$2'))')

dnl array_set(varname, idx, value)
define(`array_set', `define(format(``%s[%s]'', `$1', `$2'), `$3')')

dnl 2D versions of "array_get" and "array_set"
dnl array2_get(varname, idx1, idx2)
define(`array2_get', `defn(format(``%s[%s][%s]'', `$1', `$2', `$3'))')

dnl array2_set(varname, idx1, idx2, value)
define(`array2_set', `define(format(``%s[%s][%s]'', `$1', `$2', `$3'), `$4')')

dnl is_valid(n)
define(`is_valid', `eval(regexp(`$1', `^\s*-?[0-9]+\s*$') >= 0)')

dnl parse_int_list(varname, args):
dnl   varname["length"] = 0
dnl   foreach arg in args:
dnl     if not is_valid(arg):
dnl       Return 0
dnl     varname[varname["length"]] = arg
dnl     varname["length"] = varname["length"] + 1
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
dnl   for i = 0 to varname["length"]-1:
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

dnl list_to_matrix(arrname, mtxname, rows, cols):
dnl   mtxname["rows"] = rows
dnl   mtxname["cols"] = cols
dnl   idx = 0
dnl   for i = 0 to rows-1:
dnl     for j = 0 to cols-1:
dnl       mtxname[i][j] = arrname[idx]
dnl       idx = idx + 1
define(`list_to_matrix',
`array_set(`$2', `rows', `$3')dnl
array_set(`$2', `cols', `$4')dnl
_list_to_matrix_outer(`$1', `$2', `$3', `$4', 0, 0)'dnl
)

dnl arrname=$1, mtxname=$2, rows=$3, cols=$4, i=$5, idx=$6
define(`_list_to_matrix_outer',
`ifelse(eval($5 < $3), 1,
`_list_to_matrix_inner(`$1', `$2', `$4', `$5', 0, `$6')dnl
_list_to_matrix_outer(`$1', `$2', `$3', `$4', incr($5), eval($6 + $4))'dnl
)'dnl
)

dnl arrname=$1, mtxname=$2, cols=$3, i=$4, j=$5, idx=$6
define(`_list_to_matrix_inner',
`ifelse(eval($5 < $3), 1,
`array2_set(`$2', `$4', `$5', array_get(`$1', `$6'))dnl
_list_to_matrix_inner(`$1', `$2', `$3', `$4', incr($5), incr($6))'dnl
)'dnl
)

dnl transpose_matrix(mtxname1, mtxname2):
dnl   mtxname2["rows"] = mtxname1["cols"]
dnl   mtxname2["cols"] = mtxname2["rows"]
dnl   for i = 0 to mtxname1["rows"]-1:
dnl     for j = 0 to mtxname1["cols"]-1:
dnl       mtxname2[j][i] = mtxname1[i][j]
define(`transpose_matrix',
`array_set(`$2', `rows', array_get(`$1', `cols'))dnl
array_set(`$2', `cols', array_get(`$1', `rows'))dnl
_transpose_matrix_outer(`$1', `$2', 0)'dnl
)

dnl mtxname1=$1, mtxname2=$2, i=$3
define(`_transpose_matrix_outer',
`ifelse(eval($3 < array_get(`$1', `rows')), 1,
`_transpose_matrix_inner(`$1', `$2', `$3', 0)dnl
_transpose_matrix_outer(`$1', `$2', incr($3))'dnl
)'dnl
)

dnl mtxname1=$1, mtxname2=$2, i=$3, j=$4
define(`_transpose_matrix_inner',
`ifelse(eval($4 < array_get(`$1', `cols')), 1,
`array2_set(`$2', `$4', `$3', array2_get(`$1', `$3', `$4'))dnl
_transpose_matrix_inner(`$1', `$2', `$3', incr($4))'dnl
)'dnl
)

dnl matrix_to_list(mtxname, arrname):
dnl   arrname["length"] = 0
dnl   idx = 0
dnl   for i = 0 to mtxname["rows"]-1:
dnl     for j = 0 to mtxname["cols"]-1:
dnl       arrname[arrname["length"]] = mtxname[i][j]
dnl       arrname["length"] = arrname["length"] + 1
define(`matrix_to_list',
`array_set(`$2', `length', 0)dnl
_matrix_to_list_outer(`$1', `$2', 0)'dnl
)

dnl mtxname=$1, arrname=$2, i=$3
define(`_matrix_to_list_outer',
`ifelse(eval($3 < array_get(`$1', `rows')), 1,
`_matrix_to_list_inner(`$1', `$2', `$3', 0)dnl
_matrix_to_list_outer(`$1', `$2', incr($3))'dnl
)'dnl
)

dnl mtxname=$1, arrname=$2, i=$3, j=$4
define(`_matrix_to_list_inner',
`ifelse(eval($4 < array_get(`$1', `cols')), 1,
`array_set(`$2', array_get(`$2', `length'), array2_get(`$1', `$3', `$4'))dnl
array_set(`$2', `length', incr(array_get(`$2', `length')))dnl
_matrix_to_list_inner(`$1', `$2', `$3', incr($4))'dnl
)'dnl
)

divert(0)dnl
ifelse(eval(ARGC < 3 || !is_valid(ARGV1) || !is_valid(ARGV2)), 1, `show_usage()')dnl
ifelse(eval(len(ARGV3) < 1 || !parse_int_list(`arr', ARGV3)), 1, `show_usage()')dnl
ifelse(eval(ARGV1 < 1 || ARGV2 < 1 || array_get(`arr', `length') != ARGV1 * ARGV2), 1, `show_usage()')dnl
list_to_matrix(`arr', `mtx', ARGV2, ARGV1)dnl
transpose_matrix(`mtx', `mtx_t')dnl
matrix_to_list(`mtx_t', `arr_t')dnl
show_int_list(`arr_t')
