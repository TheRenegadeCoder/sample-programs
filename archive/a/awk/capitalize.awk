function usage() {
    print "Usage: please provide a string"
    exit(1)
}

function capitalize(s) {
    return toupper(substr(s, 1, 1)) substr(s, 2)
}

BEGIN {
    if (ARGC < 2 || !ARGV[1]) {
        usage()
    }

    print capitalize(ARGV[1])
}
