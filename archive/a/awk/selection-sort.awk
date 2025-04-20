function usage() {
    print "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""
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

# Source: https://en.wikipedia.org/wiki/Selection_sort#Implementations
function selection_sort(arr, arr_len,  i, j, t, min_pos) {
    for (i = 1; i < arr_len; i++) {
        min_pos = i
        for (j = i + 1; j <= arr_len; j++) {
            if (arr[j] < arr[min_pos]) {
                min_pos = j
            }
        }

        if (min_pos != i) {
            t = arr[i]
            arr[i] = arr[min_pos]
            arr[min_pos] = t
        }
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
    if (ARGC < 2) {
        usage()
    }

    str_to_array(ARGV[1], arr)
    arr_len = length(arr)
    if (!arr_len || arr_len < 2) {
        usage()
    }

    selection_sort(arr, arr_len)
    show_array(arr)
}
