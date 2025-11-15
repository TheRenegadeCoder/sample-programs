divert(-1)
define(`show_usage',
`Usage: please provide two lists in the format "1, 2, 3, 4, 5"
m4exit(`1')')

dnl Reference: https://www.gnu.org/software/m4/manual/m4.html#index-array
dnl array_get(var_name, idx)
define(`array_get', `defn(format(``%s[%s]'', `$1', `$2'))')

dnl array_set(var_name, idx, value)
define(`array_set', `define(format(``%s[%s]'', `$1', `$2'), `$3')')

dnl 2D versions of "array_get" and "array_set"
dnl array2_get(varname, idx1, idx2)
define(`array2_get', `defn(format(``%s[%s][%s]'', `$1', `$2', `$3'))')

dnl array2_set(varname, idx1, idx2, value)
define(`array2_set', `define(format(``%s[%s][%s]'', `$1', `$2', `$3'), `$4')')

dnl array2_append(varname, idx1, value):
dnl   varname[idx1][varname[idx1]["length"]] = value
dnl   varname[idx1]["length"] = varname[idx1]["length"] + 1
define(`array2_append',
`array2_set(`$1', `$2', array2_get(`$1', `$2', `length'), `$3')dnl
array2_set(`$1', `$2', `length', incr(array2_get(`$1', `$2', `length')))dnl
'dnl
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

dnl Source: https://en.wikipedia.org/wiki/Longest_common_subsequence
dnl However, instead of storing lengths, an index to a subsequence is stored.
dnl longest_common_subsequence(list1_varname, list2_varname, c_varname, subseq_varname, result_varname):
dnl   // Initialize all subsequences to an empty sequence
dnl   m = list1_varname["length"]
dnl   n = list2_varname["length"]
dnl   for i = 0 to m:
dnl     c_varname[i][0] = 0
dnl
dnl   for j = 0 to n:
dnl     c_varname[0][j] = 0
dnl
dnl   subseq_varname[0]["length"] = 0
dnl   subseq_varname["length"] = 1
dnl
dnl   // Find the longest common subsequence using prior subsequences
dnl   for i = 1 to m:
dnl     for j = 1 to n:
dnl       // If common element found, create new subsequence based on prior
dnl       // subsequence with the common element appended
dnl       if list1_varname[i - 1] == list2_varname[j - 1]:
dnl         c_varname[i][j] = subseq_varname["length"]
dnl         copy_array2(subseq_varname, c_varname[i - 1][j - 1], subseq_varname["length"])
dnl         array2_append(subseq_varname, subseq_varname["length"], list1_varname[i - 1])
dnl         subseq_varname[subseq_varname["length"]] = subseq_varname[subseq_varname["length"]] + 1
dnl       // Else, reuse the longer of the two prior subsequences
dnl       else:
dnl         idx1 = c_varname[i][j - 1]
dnl         idx2 = c_varname[i - 1][j]
dnl         if subseq_varname[idx1]["length"] > subseq_varname[idx2]["length"]:
dnl           c_varname[i][j] = idx1
dnl         else:
dnl           c_varname[i][j] = idx2
dnl
dnl   // Store result
dnl   result_varname["length"] = subseq_varname[c_varname[m][n]]["length"]
dnl   for i = 0 to result_varname["length"] - 1:
dnl     result_varname[i] = subseq_varname[c_varname[m][n]][i]
define(`longest_common_subsequence',
`pushdef(`m', array_get(`$1', `length'))dnl
pushdef(`n', array_get(`$2', `length'))dnl
_lcs_init_c_col0(`$3', 0)dnl
_lcs_init_c_row0(`$3', 1)dnl
array2_set(`$4', 0, `length', 0)dnl
array_set(`$4', `length', 1)dnl
_lcs_outer(`$1', `$2', `$3', `$4', 1)dnl
_lcs_store_result(`$4', array2_get(`$3', m, n), `$5')dnl
popdef(`n')dnl
popdef(`m')dnl
'dnl
)

dnl c_varname=$1, i=$2
define(`_lcs_init_c_col0',
`ifelse(eval($2 <= m), 1,
`array2_set(`$1', `$2', 0, 0)dnl
_lcs_init_c_col0(`$1', incr($2))dnl
'dnl
)'dnl
)

dnl c_varname=$1, j=$2
define(`_lcs_init_c_row0',
`ifelse(eval($2 <= n), 1,
`array2_set(`$1', 0, `$2', 0)dnl
_lcs_init_c_row0(`$1', incr($2))dnl
'dnl
)'dnl
)

dnl list1_varname=$1, list2_varname=$2, c_varname=$3, subseq_varname=$4, i=$5
define(`_lcs_outer',
`ifelse(eval($5 <= m), 1,
`_lcs_inner(`$1', `$2', `$3', `$4', `$5', 1)dnl
_lcs_outer(`$1', `$2', `$3', `$4', incr($5))dnl
'dnl
)'dnl
)

dnl list1_varname=$1, list2_varname=$2, c_varname=$3, subseq_varname=$4, i=$5, j=$6
define(`_lcs_inner',
`ifelse(eval($6 <= n), 1,
`ifelse(eval(array_get(`$1', decr($5)) == array_get(`$2', decr($6))), 1,
`array2_set(`$3', `$5', `$6', array_get(`$4', `length'))dnl
copy_array2(`$4', array2_get(`$3', decr($5), decr($6)), array_get(`$4', `length'))dnl
array2_append(`$4', array_get(`$4', `length'), array_get(`$1', decr($5)))dnl
array_set(`$4', `length', incr(array_get(`$4', `length')))',
`pushdef(`idx1', array2_get(`$3', `$5', decr($6)))dnl
pushdef(`idx2', array2_get(`$3', decr($5), `$6'))dnl
ifelse(eval(array2_get(`$4', idx1, `length') > array2_get(`$4', idx2, `length')), 1,
`array2_set(`$3', `$5', `$6', idx1)',
`array2_set(`$3', `$5', `$6', idx2)'dnl
)dnl
popdef(`idx2')dnl
popdef(`idx1')dnl
'dnl
)dnl
_lcs_inner(`$1', `$2', `$3', `$4', `$5', incr($6))dnl
'dnl
)'dnl
)

dnl copy_array2(arr2_varname, src_idx, dest_idx):
dnl   arr2_varname[dest_idx]["length"] = arr2_varname[src_idx]["length"]
dnl   for i = 0 to arr2_varname[src_idx]["length"] - 1
dnl     arr2_varname[dest_idx][i] = arr2_varname[src_idx][i]
define(`copy_array2',
`array2_set(`$1', `$3', `length', array2_get(`$1', `$2', `length'))dnl
_copy_array2(`$1', `$2', `$3', 0)dnl
'dnl
)

dnl arr2_varname=$1, src_idx=$2, dest_idx=$3, i=$4
define(`_copy_array2',
`ifelse(eval($4 < array2_get(`$1', `$2', `length')), 1,
`array2_set(`$1', `$3', `$4', array2_get(`$1', `$2', `$4'))dnl
_copy_array2(`$1', `$2', `$3', incr($4))dnl
')dnl
'dnl
)

dnl subseq_varname=$1, src_idx=$2, result_varname=$3
define(`_lcs_store_result',
`array_set(`$3', `length', array2_get(`$1', `$2', `length'))dnl
_lcs_store_result_inner(`$1', `$2', `$3', 0)dnl
'dnl
)

dnl subseq_varname=$1, src_idx=$2, result_varname=$3, i=$4
define(`_lcs_store_result_inner',
`ifelse(eval($4 < array_get(`$3', `length')), 1,
`array_set(`$3', `$4', array2_get(`$1', `$2', `$4'))dnl
_lcs_store_result_inner(`$1', `$2', `$3', incr($4))dnl
'dnl
)'dnl
)

divert(0)dnl
ifelse(eval(ARGC < 2 ||
    !parse_int_list(`list1', ARGV1) ||
    !parse_int_list(`list2', ARGV2)
), 1, `show_usage()')dnl
longest_common_subsequence(`list1', `list2', `c', `subseq', `result')dnl
show_int_list(`result')
