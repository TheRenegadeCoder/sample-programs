function usage() {
    print "Usage: please provide a string that contains at least one palindrome"
    exit(1)
}

# Source: https://www.geeksforgeeks.org/longest-palindromic-substring-using-dynamic-programming/
function longest_palindromic_substring(s,  i, j, n, matches, t, start, max_len, len) {
    # Indicate all length 1 strings match and everything else does not
    n = length(s)
    for (i = 1; i <= n; i++) {
        for (j = 1; j <= n; j++) {
            matches[i, j] = i == j
        }
    }

    # Convert string to lowercase
    t = tolower(s)

    # Find all length 2 matches
    start = 1
    max_len = 1
    for (i = 1; i < n; i++) {
        if (substr(t, i, 1) == substr(t, i + 1, 1)) {
            matches[i, i + 1] = 1
            if (max_len < 2) {
                start = i
                max_len = 2
            }
        }
    }

    # Find all length 3 or higher matches
    for (len = 3; len <= n; len++) {
        # Loop through each starting character
        for (i = 1; i <= n - len + 1; i++) {
            # If match for one character in from start and end characters
            # and start and end characters match, set match for start and
            # end characters, and update max length
            j = i + len - 1
            if (matches[i + 1, j - 1] && substr(t, i, 1) == substr(t, j, 1)) {
                matches[i, j] = 1
                if (len > max_len) {
                    max_len = len
                    start = i
                }
            }
        }
    }

    return substr(s, start, max_len)
}

BEGIN {
    if (ARGC < 2 || !ARGV[1]) {
        usage()
    }

    s = longest_palindromic_substring(ARGV[1])
    if (length(s) > 1) {
        print s
    } else {
        usage()
    }
}
