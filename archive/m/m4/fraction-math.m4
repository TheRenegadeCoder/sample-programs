divert(-1)
define(`show_usage',
`Usage: ./fraction-math operand1 operator operand2
m4exit(`1')')

define(`show_error',
`Error: $1
m4exit(`1')')

dnl is_valid_fraction(f)
define(`is_valid_fraction', `eval(regexp(`$1', `^\s*-?[0-9]+\(/\s*-?[0-9]+\)?\s*$') >= 0)')

dnl string_to_fraction(var_name, f)
define(`string_to_fraction',
`define(`idx', index(`$2', `/'))dnl
define(`num', ifelse(eval(idx < 0), 1, `$2', `substr(`$2', 0, idx)'))dnl
define(`den', ifelse(eval(idx < 0), 1, 1, `substr(`$2', incr(idx))'))dnl
fraction_reduce(`$1', num, den)'dnl
)

dnl set_fraction(var_name, num, den)
define(`set_fraction', `define(`$1_n', $2)define(`$1_d', $3)define(`$1_error', `')')

dnl set_fraction_error(var_name, error_msg)
define(`set_fraction_error', `define(`$1_error', `$2')')

dnl fraction_reduce(var_name, n, d)
dnl if d == 0:
dnl   var_name.error = "Divide by 0"
dnl else:
dnl   g = gcd(abs(n), abs(d))
dnl   if d > 0:
dnl     var_name.n, var_name.d = n / g, d / g
dnl   else:
dnl     var_name.n, var_name.d =  -n / g, -d / g
define(`fraction_reduce',
`ifelse($3, 0, `set_fraction_error(`$1', `Divide by 0')',
`define(`g', gcd(abs(`$2'), abs(`$3')))dnl
ifelse(eval($3 > 0), 1,
    `set_fraction(`$1', eval($2 / g), eval($3 / g))',
    `set_fraction(`$1', eval((0 - $2) / g), eval((0 - $3) / g))'dnl
)'dnl
)'dnl
)

dnl gcd(a, b)
dnl if a == 0:
dnl   Return b
dnl else:
dnl   while b != 0:
dnl     a, b = b, a % b
dnl   Return a
define(`gcd', `ifelse(`$1', 0, `$2', `$2', 0, `$1', `gcd($2, eval($1 % $2))')')

dnl abs(n)
define(`abs', `ifelse(eval($1 >= 0), 1, eval($1), eval(0 - $1))')

dnl fraction_math(result_var_name, var_name1, op, var_name2)
define(`fraction_math',
`set_fraction_error(`$1', `')dnl
ifelse(
    `$3', `+', `fraction_add($1, $2, $4)',
    `$3', `-', `fraction_sub($1, $2, $4)',
    `$3', `*', `fraction_mul($1, $2, $4)',
    `$3', `/', `fraction_div($1, $2, $4)',
    `$3', `==', `fraction_cmp($1, $2, $3, $4)',
    `$3', `!=', `fraction_cmp($1, $2, $3, $4)',
    `$3', `<', `fraction_cmp($1, $2, $3, $4)',
    `$3', `<=', `fraction_cmp($1, $2, $3, $4)',
    `$3', `>', `fraction_cmp($1, $2, $3, $4)',
    `$3', `>=', `fraction_cmp($1, $2, $3, $4)',
    `set_fraction_error(`$1', `Invalid operation "$3"')'dnl
)'dnl
)

dnl fraction_add(result_varname, f1, f2)
dnl f1.n/f1.d + f2.n/f2.d = (f1.n*f2.d + f2.n*f1.d) / (f1.d*f2.d)
define(`fraction_add', `fraction_reduce(`$1', eval($2_n * $3_d + $3_n * $2_d), eval($2_d * $3_d))')

dnl fraction_sub(result_varname, f1, f2)
dnl f1.n/f1.d - f2.n/f2.d = (f1.n*f2.d - f2.n*f1.d) / (f1.d*f2.d)
define(`fraction_sub', `fraction_reduce(`$1', eval($2_n * $3_d - $3_n * $2_d), eval($2_d * $3_d))')

dnl fraction_mul(result_varname, f1, f2)
dnl f1.n/f1.d * f2.n/f2.d = (f1.n*f2.n) / (f1.d*f2.d)
define(`fraction_mul', `fraction_reduce(`$1', eval($2_n * $3_n), eval($2_d * $3_d))')

dnl fraction_div(result_varname, f1, f2)
dnl (f1.n/f1.d) / (f2.n/f2.d) = (f1.n*f2.d) / (f2.n*f1.d)
define(`fraction_div', `fraction_reduce(`$1', eval($2_n * $3_d), eval($3_n * $2_d))')

dnl fraction_cmp(result_varname, f1, op, f2)
dnl f1.n/f1.d op f2.n/f2.d = f1.n*f2.d op f2.n*f1.d
define(`fraction_cmp', `define(`$1', eval(($2_n * $4_d) $3 ($4_n * $2_d)))')

dnl fraction_to_string(varname)
define(`fraction_to_string', `ifdef(`$1', `$1', `$1_n/$1_d')')
divert(0)dnl
ifelse(eval(ARGC < 3 || !is_valid_fraction(ARGV1) || !is_valid_fraction(ARGV3)), 1, `show_usage()')dnl
string_to_fraction(`f1', ARGV1)dnl
ifelse(eval(len(f1_error) > 0), 1, `show_error(f1_error)')dnl
string_to_fraction(`f2', ARGV3)dnl
ifelse(eval(len(f2_error) > 0), 1, `show_error(f2_error)')dnl
fraction_math(`result', `f1', ARGV2, `f2')dnl
ifelse(eval(len(result_error) > 0), 1, `show_error(result_error)')dnl
fraction_to_string(`result')
