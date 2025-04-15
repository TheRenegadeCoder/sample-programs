function usage() {
    print "Usage: please provide a string"
    exit(1)
}

function remove_whitespace(s,  arr, result) {
    split(s, arr, /\s+/)
    result = ""
    for (k in arr) {
        result = result arr[k]
    }

    return result
}

BEGIN {
    if (ARGC < 2 || !ARGV[1]) {
        usage()
    }

    print remove_whitespace(ARGV[1])
}
