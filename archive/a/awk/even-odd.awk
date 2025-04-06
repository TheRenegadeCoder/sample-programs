function usage() {
    print "Usage: please input a number"
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
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

    print is_even(result) ? "Even" : "Odd"
}
