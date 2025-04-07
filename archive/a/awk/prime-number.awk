function usage() {
    print "Usage: please input a non-negative integer"
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

function is_prime(n) {
    result = 1
    if (n < 2 || (n % 2 == 0 && n != 2)) {
        result = 0
    } else {
        q = sqrt(n)
        for (i = 3; i <= q; i += 2) {
            if (n % i == 0) {
                result = 0
                break
            }
        }
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
