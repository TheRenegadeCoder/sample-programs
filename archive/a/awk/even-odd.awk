function usage() {
    print "Usage: please input a number"
    exit(1)
}

function str_to_number(s) {
    result = "ERROR"
    if (s ~ /^\s*[+-]*[0-9]+\s*$/) {
        result = strtonum(s)
    }

    return result
}

function is_even(n) {
    return (n % 2) == 0
}

BEGIN {
    if (ARGC < 2) {
        usage()
    }

    result = str_to_number(ARGV[1])
    if (result == "ERROR") {
        usage()
    }

    if (is_even(result)) {
        print "Even"
    } else {
        print "Odd"
    }
}
