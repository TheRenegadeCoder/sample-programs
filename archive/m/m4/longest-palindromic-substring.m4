divert(-1)
define(`show_usage',
`Usage: please provide a string that contains at least one palindrome
m4exit(`1')')

dnl longest_palindromic_substring(str)
dnl start = 0
dnl max_len = 1
dnl _lps_outer(str, 2)
dnl Return str[start:start+max_len-1]
define(`longest_palindromic_substring',
`pushdef(`start', 0)dnl
pushdef(`max_len', 1)dnl
_lps_outer(`$1', 2)dnl
substr(`$1', start, max_len)`'dnl
popdef(`max_len')dnl
popdef(`start')dnl
'dnl
)

dnl _lps_outer(str, l)
dnl while l <= len(str):
dnl   _lps_inner(str, 0, l)
dnl   l = l + 1
define(`_lps_outer',
`ifelse(eval($2 <= len(`$1')), 1, `_lps_inner(`$1', 0, $2)dnl
_lps_outer(`$1', incr($2))'dnl
)'dnl
)

dnl _lps_inner(str, k, l)
dnl while k <= len(str) - l and l > max_len:
dnl   if is_palindrome(str[k..k+l-1], 0, l, 1):
dnl     start = k
dnl     max_len = l
dnl   k = k + 1
define(`_lps_inner',
`ifelse(
eval($2 <= len(`$1') - $3 && $3 > max_len), 1,
`ifelse(
eval(is_palindrome(`$1', $2, eval($2 + $3 - 1), 1)), 1,
`define(`start', $2)dnl
define(`max_len', $3)'dnl
)dnl
_lps_inner(`$1', incr($2), $3)'dnl
)'dnl
)

dnl is_palidrome(str, left, right, result)
dnl while result and left < right:
dnl   result = str[left] == str[right]
dnl   left = left + 1
dnl   right = right - 1
dnl Return result
define(`is_palindrome',
`ifelse(eval($4 && $2 < $3), 1,
`is_palindrome(`$1', incr($2), decr($3), `ifelse(substr(`$1', $2, 1), substr(`$1', $3, 1), 1, 0)')',
`$4'dnl
)'dnl
)
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1), 1, `show_usage()')dnl
define(`result', longest_palindromic_substring(ARGV1))dnl
ifelse(eval(len(result) < 2), 1, `show_usage()', `result')
