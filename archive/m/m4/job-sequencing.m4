divert(-1)
define(`show_usage',
`Usage: please provide a list of profits and a list of deadlines
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

dnl array2_swap(varname, idx1, idx2, common_idx):
dnl   t = varname[idx1][common_idx]
dnl   varname[idx1][common_idx] = varname[idx2][common_idx]
dnl   varname[idx2][common_idx] = t
define(`array2_swap',
`pushdef(`t', array2_get(`$1', `$2', `$4'))dnl
array2_set(`$1', `$2', `$4', array2_get(`$1', `$3', `$4'))dnl
array2_set(`$1', `$3', `$4', t)dnl
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

dnl Reference: https://www.techiedelight.com/job-sequencing-problem-deadlines/
dnl job_sequencing(profits_varname, deadlines_varname, jobs_varname, slots_varname):
dnl   // Set up job details and longest deadline
dnl   longest_deadline = 0
dnl   jobs_varname["length"] = profits_varname["length"]
dnl   for i = 0 to profits_varname["length"] - 1:
dnl     jobs_varname[i]["profit"] = profits_varname[i]
dnl     jobs_varname[i]["deadline"] = deadlines_varname[i]
dnl     if deadlines_varname[i] > longest_deadline:
dnl       longest_deadline = deadlines_varname[i]
dnl
dnl   // Initialize job slots
dnl   slots_varname["length"] = longest_deadline + 1
dnl   for i = 0 to longest_deadline:
dnl     slots_varname[i] = -1
dnl
dnl   // Sort jobs by profit then deadline
dnl   bubble_sort(jobs_varname)
dnl
dnl   // For each job, see if there is available slot at or before the deadline
dnl   // if so, store this job in that slot
dnl   for i = 0 to jobs_varname["length"] - 1:
dnl     for j = jobs_varname[i]["deadline"] down to 1:
dnl       if slots_varname[j] < 0:
dnl         slots_varname[j] = i
dnl         break
define(`job_sequencing',
`pushdef(`longest_deadline', 0)dnl
_set_jobs(`$1', `$2', `$3')dnl
_init_slots(`$4')dnl
bubble_sort(`$3')dnl
_set_slots(`$3', `$4', 0)dnl
popdef(`longest_deadline')dnl
'dnl
)

dnl profits_varname=$1, deadlines_varname=$2, jobs_varname=$3
define(`_set_jobs',
`array_set(`$3', `length', array_get(`$1', `length'))dnl
_set_jobs_inner(`$1', `$2', `$3', 0)dnl
'dnl
)

dnl profits_varname=$1, deadlines_varname=$2, jobs_varname=$3, i=$4
define(`_set_jobs_inner',
`ifelse(eval($4 < array_get(`$1', `length')), 1,
`array2_set(`$3', `$4', `profit', array_get(`$1', `$4'))dnl
array2_set(`$3', `$4', `deadline', array_get(`$2', `$4'))dnl
ifelse(eval(array_get(`$2', `$4') > longest_deadline), 1,
`define(`longest_deadline', array_get(`$2', `$4'))')dnl
_set_jobs_inner(`$1', `$2', `$3', incr($4))'dnl
)'dnl
)

dnl slots_varname=$1
define(`_init_slots',
`array_set(`$1', `length', incr(longest_deadline))dnl
_init_slots_inner(`$1', 0)dnl
'dnl
)

dnl slots_varname=$1, i=$2
define(`_init_slots_inner',
`ifelse(eval($2 <= longest_deadline), 1,
`array_set(`$1', `$2', -1)dnl
_init_slots_inner(`$1', incr($2))'dnl
)'dnl
)

dnl jobs_varname=$1, slots_varname=$2, i=$3
define(`_set_slots',
`ifelse(eval($3 < array_get(`$1', `length')), 1,
`_set_slots_inner(`$2', `$3', array2_get(`$1', `$3', `deadline'))dnl
_set_slots(`$1', `$2', incr($3))'dnl
)'dnl
)

dnl slots_varname=$1, i=$2, j=$3
define(`_set_slots_inner',
`ifelse(eval($3 >= 1), 1,
`ifelse(eval(array_get(`$1', `$3') < 0), 1,
`array_set(`$1', `$3', `$2')',
`_set_slots_inner(`$1', `$2', decr($3))'dnl
)'dnl
)'dnl
)

dnl Reference: https://en.wikipedia.org/wiki/Bubble_sort#Pseudocode_implementation
dnl bubble_sort(varname):
dnl   n = varname[length]
dnl   do:
dnl     swapped = false
dnl     for i from 1 to n-1:
dnl       if compare_jobs(varname, i-1, i):
dnl         swap_jobs(varname, i-1, i)
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
`ifelse(eval(compare_jobs(`$1', decr($2), `$2')), 1,
0, `swap_jobs(`$1', decr($2), $2)1'`'dnl
)'dnl
)

dnl compare_jobs(job_varname, idx1, idx2):
dnl   // Prioritize by profit, then deadline:
dnl   // 0 means jobs need to be swapped, 1 otherwise
dnl   return (job_varname[idx1]["profit"] > job_varname[idx2]["profit"]) or
dnl     (job_varname[idx1]["profit"] == job_varname[idx2]["profit"] and
dnl      job_varname[idx1]["deadline"] > job_varname[idx2]["deadline"])
define(`compare_jobs',
`eval(
    array2_get(`$1', `$2', `profit') > array2_get(`$1', `$3', `profit') ||
    (array2_get(`$1', `$2', `profit') == array2_get(`$1', `$3', `profit') &&
    array2_get(`$1', `$2', `deadline') > array2_get(`$1', `$3', `deadline'))
)'dnl
)

dnl swap_jobs(job_varname, idx1, idx2):
dnl   swap(job_varname[idx1]["profit"], job_varname[idx2]["profit"])
dnl   swap(job_varname[idx1]["deadline"], job_varname[idx2]["deadline"])
define(`swap_jobs',
`array2_swap(`$1', `$2', `$3', `profit')dnl
array2_swap(`$1', `$2', `$3', `deadline')'dnl
)

dnl get_total_profit(jobs_varname, slots_varname):
dnl   total = 0
dnl   for i = 1 to slots_varname["length"] - 1:
dnl     if slots_varname[i] >= 0:
dnl       total = total + jobs_varname[slots_varname[i]]["profit"]
dnl   return total
define(`get_total_profit', `_get_total_profit(`$1', `$2', 0, 1)')

dnl jobs_varname=$1, slots_varname=$2, total=$3, i=$4
define(`_get_total_profit',
`ifelse(eval($4 >= array_get(`$2', `length')), 1, `$3',
`ifelse(eval(array_get(`$2', `$4') >= 0), 1,
`_get_total_profit(`$1', `$2', eval($3 + array2_get(`$1', array_get(`$2', `$4'), `profit')), incr($4))',
`_get_total_profit(`$1', `$2', `$3', incr($4))'dnl
)'dnl
)'dnl
)

divert(0)dnl
ifelse(eval(
    ARGC < 2 ||
    !parse_int_list(`profits', ARGV1) ||
    !parse_int_list(`deadlines', ARGV2)
), 1, `show_usage()')dnl
ifelse(eval(
    array_get(`profits', `length') != array_get(`deadlines', `length')
), 1, `show_usage()')dnl
job_sequencing(`profits', `deadlines', `jobs', `slots')dnl
get_total_profit(`jobs', `slots')
