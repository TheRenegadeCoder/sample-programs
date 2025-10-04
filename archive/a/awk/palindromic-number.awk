function usage() {
    print "Usage: please input a non-negative integer"
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

function is_palindromic_number(n,  s, left, right, result) {
    result = 1
    s  = sprintf("%s", n)
    left = 1
    right = length(s)
    while (result && left < right) {
        result = (substr(s, left++, 1) == substr(s, right--, 1))
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

    print is_palindromic_number(result) ? "true" : "false"
}
