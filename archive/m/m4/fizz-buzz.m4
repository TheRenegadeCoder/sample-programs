dnl Source: https://github.com/tar-mirror/gnu-m4/blob/master/examples/forloop.m4
divert(`-1')
# forloop(var, from, to, stmt) - simple version
define(`forloop', `pushdef(`$1', `$2')_forloop($@)popdef(`$1')')
define(`_forloop',
    `$4`'ifelse($1, `$3', `', `define(`$1', incr($1))$0($@)')')
divert`'dnl
dnl
forloop(`i', 1, 100,
    `ifelse(eval(i % 15), 0, FizzBuzz,
    `ifelse(eval(i % 3), 0, Fizz,
    `ifelse(eval(i % 5), 0, Buzz, i)')')'
)dnl
