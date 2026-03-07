divert(-1)
define(`show_usage',
`Usage: please input a non-negative integer
m4exit(`1')')

dnl is_valid(n)
define(`is_valid', `eval(regexp(`$1', `^\s*-?[0-9]+\s*$') >= 0)')

dnl Reference: https://www.gnu.org/software/m4/manual/m4.html#index-array
dnl array_get(var_name, idx)
define(`array_get', `defn(format(``%s[%s]'', `$1', `$2'))')

dnl array_set(var_name, idx, value)
define(`array_set', `define(format(``%s[%s]'', `$1', `$2'), `$3')')

dnl show_int_list(varname):
dnl   for i = 0 to varname["length"] - 1:
dnl      if i > 0:
dnl        Output ", "
dnl      Output varname[i]
define(`show_int_list', `_show_int_list(`$1', 0)')
define(`_show_int_list',
`ifelse(eval(`$2' < array_get(`$1', `length')), 1,
`ifelse(eval(`$2' > 0), 1, `, ')dnl
array_get(`$1', `$2')`'dnl
_show_int_list(`$1', incr($2))'`'dnl
)'dnl
)

dnl fibonacci(value, result_varname):
dnl   a = 1
dnl   b = 2
dnl   result_varname["length"] = 0
dnl   while a <= value:
dnl     result_varname[result_varname["length"]] = a
dnl     result_varname["length"] = result_varname["length"] + 1
dnl     a, b = b, a + b
define(`fibonacci',
`array_set(`$2', `length', 0)dnl
_fibonacci(`$1', `$2', 1, 2)'dnl
)

dnl value=$1, result_varname=$2, a=$3, b=$4
define(`_fibonacci',
`ifelse(eval(`$3' <= `$1'), 1,
`array_set(`$2', array_get(`$2', `length'), `$3')dnl
array_set(`$2', `length', eval(incr(array_get(`$2', `length'))))dnl
_fibonacci(`$1', `$2', `$4', eval(`$3 + $4'))'dnl
)'dnl
)

dnl zeckendorf(value, fibs_varname, zecks_varname)
dnl   fibonacci(value, fibs_varname)
dnl   zecks_varname["length"] = 0
dnl   n = fibs_varname["length"] - 1
dnl   while n >= 0 and value > 0:
dnl     if fibs_varname[n] >= value:
dnl       zecks_varname[zecks_varname["length"]] = fibs_varname[n]
dnl       zecks_varname["length"] = zecks_varname["length"] + 1
dnl       value = value - fibs_varname[n]
dnl       n = n - 2
dnl     else:
dnl       n = n - 1
define(`zeckendorf',
`fibonacci(`$1', `$2')dnl
array_set(`$3', `length', 0)dnl
_zeckendorf(`$1', `$2', `$3', decr(array_get(`$2', `length')))dnl
'dnl
)

dnl value=$1, fibs_varname=$2, zecks_varname=$3, n=$4
define(`_zeckendorf',
`ifelse(eval(`$4' >= 0 && `$1' > 0), 1,
`ifelse(eval(array_get(`$2', `$4') <= `$1'), 1,
`array_set(`$3', array_get(`$3', `length'), array_get(`$2', `$4'))dnl
array_set(`$3', `length', incr(array_get(`$3', `length')))dnl
_zeckendorf(eval(`$1' - array_get(`$2', `$4')), `$2', `$3', eval(`$4' - 2))dnl
',dnl
`_zeckendorf(`$1', `$2', `$3', decr(`$4'))'dnl
)'dnl
)'dnl
)

divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1 || !is_valid(ARGV1)), 1, `show_usage()')dnl
ifelse(eval(ARGV1 < 0), 1, `show_usage()')dnl
zeckendorf(ARGV1, `fibs', `zecks')dnl
show_int_list(`zecks')
