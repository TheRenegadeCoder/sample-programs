function usage() {
    print "Usage: please provide a string to encrypt"
    exit(1)
}

function rot13(s) {
    input_table  = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    output_table = "NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm"
    result = ""
    for (i = 1; i <= length(s); i++) {
        c = substr(s, i, 1)
        idx = index(input_table, c)
        if (idx > 0) {
            c = substr(output_table, idx, 1)
        }
        
        result = result c
    }

    return result
}

BEGIN {
    if (ARGC < 2 || !ARGV[1]) {
        usage()
    }

    print rot13(ARGV[1])
}
