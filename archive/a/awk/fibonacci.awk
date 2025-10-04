function usage() {
    print "Usage: please input the count of fibonacci numbers to output"
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

function fibonacci(n,  i, a, b, c) {
    a = 0
    b = 1
    for (i = 1; i <= n; i++) {
        c = a + b
        a = b
        b = c
        printf("%d: %d\n", i, a)
    }
}

BEGIN {
    if (ARGC < 2) {
        usage()
    }

    result = str_to_number(ARGV[1])
    if (result == "ERROR" || result < 0) {
        usage()
    }

    fibonacci(result)
}
