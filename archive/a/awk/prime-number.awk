function usage() {
    print "Usage: please input a non-negative integer"
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

function is_prime(n,  result, q, i) {
    result = (n == 2) || (n > 2 && n % 2 != 0)
    q = sqrt(n)
    for (i = 3; result && i <= q; i += 2) {
        result = (n % i != 0)
    }

    return result
}

BEGIN {
    if (ARGC < 2) {
        usage()
    }

    result = str_to_number(ARGV[1])
    if (result == "ERROR" || result < 0) {
        usage()
    }

    print is_prime(result) ? "prime" : "composite"
}
