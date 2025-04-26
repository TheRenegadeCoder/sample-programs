function usage() {
    print "Usage: please provide two lists in the format \"1, 2, 3, 4, 5\""
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

function str_to_array(s, arr,  str_arr, idx, result) {
    split(s, str_arr, ",")
    for (idx in str_arr) {
        result = str_to_number(str_arr[idx])
        if (result == "ERROR") {
            delete arr
            arr[1] = "ERROR"
            break
        } else {
            arr[idx] = result
        }
    }
}

# Source: https://en.wikipedia.org/wiki/Longest_common_subsequence
# However, instead of storing lengths, an index to a subsequence is stored.
function longest_common_subsequence(list1, m, list2, n, arr,  \
    i, j, k, c, subsequences, num_subsequences, len1, len2) {
    # Initialize subsequences of length 0
    for (i = 0; i <= m; i++) {
        c[i, 0] = 0
    }

    for (j = 0; j <=n; j++) {
        c[0, j] = 0
    }

    num_subsequences = 0

    # Find the longest common subsequence using prior subsequences
    for (i = 1; i <= m; i++) {
        for (j = 1; j <= n; j++) {
            # If common element found, create new subsequence based on prior
            # subsequence with the common element appended
            if (list1[i] == list2[j]) {
                num_subsequences++
                c[i, j] = num_subsequences
                len1 = length(subsequences[c[i - 1, j - 1]])
                copy_array(subsequences[c[i - 1, j - 1]], len1, subsequences[num_subsequences])
                subsequences[num_subsequences][len1 + 1] = list1[i]
            } else {
                # Else, reuse the longer of the two prior subsequences
                len1 = length(subsequences[c[i, j - 1]])
                len2 = length(subsequences[c[i - 1, j]])
                c[i, j] = (len1 > len2) ? c[i, j - 1] : c[i - 1, j]
            }
        }
    }

    len1 = length(subsequences[c[m, n]])
    copy_array(subsequences[c[m, n]], len1, arr)
}

function copy_array(arr_src, arr_src_len, arr_dest,  i) {
    for (i = 1; i <= arr_src_len; i++) {
        arr_dest[i] = arr_src[i]
    }
}

function show_array(arr,  idx, s) {
    s = ""
    for (idx in arr) {
        if (s) {
            s = s ", "
        }
        s = s arr[idx]
    }

    print s
}

BEGIN {
    if (ARGC < 3) {
        usage()
    }

    str_to_array(ARGV[1], list1)
    m = length(list1)
    str_to_array(ARGV[2], list2)
    n = length(list2)
    if (!m || list1[1] == "ERROR" || !n || list2[1] == "ERROR") {
        usage()
    }

    longest_common_subsequence(list1, m, list2, n, arr)
    show_array(arr)
}
