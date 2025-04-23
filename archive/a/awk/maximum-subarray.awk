function usage() {
    print "Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\""
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

function max(a, b) {
    return (a > b) ? a : b
}

# Find maximum subarray using Kadane's algorithm.
# Source: https://en.wikipedia.org/wiki/Maximum_subarray_problem#No_empty_subarrays_admitted
function maximum_subarray(arr, n,  i, best_sum, current_sum) {
    # Awk doesn't have minus infinity, so use large negative number
    best_sum = -1e999
    current_sum = 0
    for (i = 1; i <=n ; i++) {
        current_sum = arr[i] + max(0, current_sum)
        best_sum = max(current_sum, best_sum)
    }

    return best_sum
}

BEGIN {
    if (ARGC < 2) {
        usage()
    }

    str_to_array(ARGV[1], arr)
    arr_len = length(arr)
    if (!arr_len || arr[1] == "ERROR") {
        usage()
    }

    result = maximum_subarray(arr, arr_len)
    printf("%d\n", result)
}
