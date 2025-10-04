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

# Source: https://en.wikipedia.org/wiki/Bubble_sort#Optimizing_bubble_sort
function bubble_sort(arr, arr_len,  i, t, n, new_n) {
    n = arr_len
    do {
        new_n = 1
        for (i = 2; i <= n; i++) {
            if (arr[i - 1] > arr[i]) {
                t = arr[i - 1]
                arr[i - 1] = arr[i]
                arr[i] = t
                new_n = i
            }
        }

        n = new_n
    } while (n > 1)
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

    bubble_sort(arr, arr_len)
    show_array(arr)
}
