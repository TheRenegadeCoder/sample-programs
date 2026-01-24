function usage() {
    print "Usage: please input a non-negative integer"
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

function fibonacci_up_to(n, fibs,  a, b, c, k) {
    a = 1
    b = 2
    for (k = 1; a <= n; k++) {
        fibs[k] = a
        c = a + b
        a = b
        b = c
    }
}

function zeckendorf(n, zecks,  i, k) {
    fibonacci_up_to(n, fibs)
    k = length(fibs)
    i = 1
    while (k > 0 && n > 0) {
        fib = fibs[k]
        if (fib <= n) {
            zecks[i++] = fib
            n -= fib
            k -= 2
        } else {
            k--
        }
    }
}

function show_array(arr,  idx, s) {
    s = ""
    for (idx in arr) {
        if (s) {
            s = s ", "
        }
        s = s arr[idx]
    }

    print s
}

BEGIN {
    if (ARGC < 2) {
        usage()
    }

    n = str_to_number(ARGV[1])
    if (n == "ERROR" || n < 0) {
        usage()
    }

    zeckendorf(n, zecks)
    show_array(zecks)
}
