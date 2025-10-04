function usage() {
    print "Usage: please provide a string"
    exit(1)
}

function duplicate_character_counter(s, counts, order,  i, c) {
    for (i = 1; i <= length(s); i++) {
        c = substr(s, i, 1)
        if (!(c in counts)) {
            order[i] = c
        }

        counts[c]++
    }
}

function display_duplicate_character_counts(counts, order,  dupes, idx, c) {
    dupes = 0
    for (idx in order) {
        c = order[idx]
        if (counts[c] > 1) {
            print c ": " counts[c]
            dupes = 1
        }
    }

    if (!dupes) {
        print "No duplicate characters"
    }
}

BEGIN {
    if (ARGC < 2 || !ARGV[1]) {
        usage()
    }

    s = ARGV[1]
    duplicate_character_counter(s, counts, order)
    display_duplicate_character_counts(counts, order)
}
