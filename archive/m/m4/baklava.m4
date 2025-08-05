divert(-1)
dnl concat(s1, s2)
define(`concat', `$1$2')
dnl repeat(string, count)
define(`repeat', `ifelse(eval(($2) > 0), 1, `concat($1, repeat($1, eval(($2) - 1)))', )')
dnl indent(count, string)
define(`indent', `ifelse(eval(($1) > 0), 1, `format(`%$1s%s', `', $2)', $2)')
dnl abs(n)
define(`abs', `ifelse(eval(($1) >= 0), 1, eval($1), eval(0 - $1))')
dnl baklava(n, stop)
define(`baklava',
`ifelse(eval($1 <= $2), 1, `baklava_line($1)
baklava(eval($1 + 1), $2)', )'dnl
)
dnl baklava_line(n)
define(`baklava_line', `indent(abs($1), repeat(`*', 21 - 2 * abs($1)))')
divert(0)dnl
baklava(-10, 10)dnl
