divert(-1)
define(`show_usage',
`Usage: please provide a string
m4exit(`1')')

dnl Reference: https://www.gnu.org/software/m4/manual/m4.html#index-array
dnl array_get(var_name, idx)
define(`array_get', `defn(format(``%s[%s]'', `$1', `$2'))')

dnl array_set(var_name, idx, value)
define(`array_set', `define(format(``%s[%s]'', `$1', `$2'), `$3')')

dnl count_duplicate_chars(str, var_name)
dnl foreach character in str (ch):
dnl   if ch not in var_name:
dnl     var_name[ch] = 1
dnl   else:
dnl     var_name[ch] = var_name[ch] + 1
define(`count_duplicate_chars',
`ifelse(eval(len(`$1') > 0), 1,
`define(`ch', substr(`$1', 0, 1))dnl
array_set(`$2', ch, eval(array_get(`$2', ch) + 1))dnl
count_duplicate_chars(substr(`$1', 1), `$2')'dnl
)'dnl
)

dnl show_duplicate_char_counts(str, var_name)
define(`show_duplicate_char_counts', `_show_duplicate_char_counts(`$1', `$2', `')')

dnl _show_duplicate_char_counts(str, var_name, has_dupes, dupe_chars)
dnl foreach characters in str (ch):
dnl   if var_name[ch] > 1 and ch not in dupe_chars:
dnl     dupe_chars = dupe_chars + ch
dnl     Output ch ": " var_name[ch]
dnl if dupe_chars is empty:
dnl   Output "No duplicate characters"
define(`_show_duplicate_char_counts',
`ifelse(eval(len(`$1') > 0), 1,
`define(`ch', substr(`$1', 0, 1))dnl
ifelse(eval(array_get(`$2', ch) > 1 && index(`$3', ch) < 0), 1,
`ch: array_get(`$2', ch)
_show_duplicate_char_counts(substr(`$1', 1), `$2', `$3'`'ch)',
`_show_duplicate_char_counts(substr(`$1', 1), `$2', `$3')'dnl
)',
len(`$3'), 0, `No duplicate characters'
)'dnl
)
divert(0)dnl
ifelse(eval(ARGC < 1 || len(ARGV1) < 1), 1, `show_usage()')dnl
count_duplicate_chars(ARGV1, `counts')dnl
show_duplicate_char_counts(ARGV1, `counts')dnl
