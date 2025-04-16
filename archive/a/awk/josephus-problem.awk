function usage() {
    print "Usage: please input the total number of people and number of people to skip."
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

# Reference: https://en.wikipedia.org/wiki/Josephus_problem#The_general_case
#
# Use zero-based index algorithm:
#
#     g(1, k) = 0
#     g(m, k) = [g(m - 1, k) + k] MOD m, for m = 2, 3, ..., n
#
# Final answer is g(n, k) + 1 to get back to one-based index
function josephus_problem(n, k,  g, m) {
    g = 0
    for (m = 2; m <= n; m++) {
        g = (g + k) % m
    }

    return g + 1
}

BEGIN {
    if (ARGC < 3) {
        usage()
    }

    n = str_to_number(ARGV[1])
    k = str_to_number(ARGV[2])
    if (n == "ERROR" || k == "ERROR") {
        usage()
    }

    print josephus_problem(n, k)
}
