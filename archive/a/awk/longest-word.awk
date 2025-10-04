function usage() {
    print "Usage: please provide a string"
    exit(1)
}

function longest_word(s,  len, max_len, k) {
    split(s, arr, /\s+/)
    max_len = 0
    for (k in arr) {
        len = length(arr[k])
        if (len > max_len) {
            max_len = len
        }
    }

    return max_len
}

BEGIN {
    if (ARGC < 2 || !ARGV[1]) {
        usage()
    }

    print longest_word(ARGV[1])
}
