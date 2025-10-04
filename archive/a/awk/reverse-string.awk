function reverse_string(s,  result, i) {
    result = ""
    for (i = length(s); i > 0; i--) {
        result = result substr(s, i, 1)
    }

    return result
}

BEGIN {
    if (ARGC > 1) {
        print reverse_string(ARGV[1])
    }
}
