divert(-1)
define(`show_usage',
`Usage: ./fraction-math operand1 operator operand2
m4exit(`1')')

define(`show_error',
`divert(0)Error: $1
m4exit(`1')')

dnl is_valid_fraction(f)
define(`is_valid_fraction', `eval(regexp(`$1', `^\s*-?[0-9]+\(/\s*-?[0-9]+\)?\s*$') >= 0)')

dnl fraction_to_ints(f)
define(`fraction_to_ints',
`define(`idx', `index(`$1', `/')')dnl
ifelse(eval(idx < 0), 1, `$1,1', `fraction_reduce(substr(`$1', 0, idx), substr(`$1', incr(idx)))')'dnl
)

dnl fraction_reduce(n, d)
dnl if d == 0:
dnl   Output "Divide by 0" and exit
dnl g = gcd(abs(n), abs(d))
dnl if d > 0:
dnl   Return (0 - n) / g, (0 - d) / g
dnl else:
dnl   Return n / g, d / g
define(`fraction_reduce',
`ifelse(`$2', 0, `show_error(`Divide by 0')')dnl
define(`g', gcd(abs(`$1'), abs(`$2')))dnl
ifelse(eval(($2) > 0), 1, `eval($1 / g),eval($2 / g)', `eval((0 - $1) / g),eval((0 - $2) / g)')'dnl
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

dnl fraction_math(n1, d1, op, n2, d2)
define(`fraction_math',
`ifelse(`$3', `+', `fraction_add($1, $2, $4, $5)',
    `$3', `-', `fraction_sub($1, $2, $4, $5)',
    `$3', `*', `fraction_mul($1, $2, $4, $5)',
    `$3', `/', `fraction_div($1, $2, $4, $5)',
    `$3', `==', `fraction_cmp($1, $2, $3, $4, $5)',
    `$3', `!=', `fraction_cmp($1, $2, $3, $4, $5)',
    `$3', `<', `fraction_cmp($1, $2, $3, $4, $5)',
    `$3', `<=', `fraction_cmp($1, $2, $3, $4, $5)',
    `$3', `>', `fraction_cmp($1, $2, $3, $4, $5)',
    `$3', `>=', `fraction_cmp($1, $2, $3, $4, $5)',
    `show_error(`Invalid operation ``$3''')'
)'dnl
)

dnl fraction_add(n1, d1, n2, d2)
dnl n1/d1 + n2/d2 = (n1*d2 + n2*d1) / (d1*d2)
define(`fraction_add', `fraction_reduce(eval($1 * $4 + $3 * $2), eval($2 * $4))')

dnl fraction_sub(n1, d1, n2, d2)
dnl n1/d1 - n2/d2 = (n1*d2 - n2*d1) / (d1*d2)
define(`fraction_sub', `fraction_reduce(eval($1 * $4 - $3 * $2), eval($2 * $4))')

dnl fraction_mul(n1, d1, n2, d2)
dnl n1/d1 * n2/d2 = (n1*n2) / (d1*d2)
define(`fraction_mul', `fraction_reduce(eval($1 * $3), eval($2 * $4))')

dnl fraction_div(n1, d1, n2, d2)
dnl (n1/d1) / (n2/d2) = (n1*d2) / (n2*d1)
define(`fraction_div', `fraction_reduce(eval($1 * $4), eval($3 * $2))')

dnl fraction_cmp(n1, d1, op, n2, d2)
dnl n1/ d1 op n2/d2 = n1*d2 op n2*d1
define(`fraction_cmp', `eval(($1 * $5) $3 ($2 * $4))')

dnl fraction_to_string(n, d)
define(`fraction_to_string', `ifelse($#, 1, $1, $1/$2)')
divert(0)dnl
ifelse(eval(ARGC < 3 || !is_valid_fraction(ARGV1) || !is_valid_fraction(ARGV3)), 1, `show_usage()')dnl
define(`f1', `fraction_to_ints(ARGV1)')dnl
define(`f2', `fraction_to_ints(ARGV3)')dnl
define(`result', `fraction_math(f1, ARGV2, f2)')dnl
divert(-1)
f1, f2, result dnl Force error message output
divert(0)dnl
fraction_to_string(result)
