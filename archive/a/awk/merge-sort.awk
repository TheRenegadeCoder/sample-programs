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

# Source: https://en.wikipedia.org/wiki/Merge_sort#Top-down_implementation
function merge_sort(arr_a, arr_a_len,  idx, arr_b) {
    # Create temporary work array and copy the values into it
    for (idx in arr_a) {
        arr_b[idx] = arr_a[idx]
    }

    # Run the recursive merge sort
    merge_sort_rec(arr_a, 1, arr_a_len + 1, arr_b)
}

function merge_sort_rec(arr_b, lo, hi, arr_a,  mid) {
    # Only sort if enough values
    if (hi - lo > 1) {
        # Get midpoint
        mid = rshift(lo + hi, 1)

        # Sort the left half (low to midpoint - 1) from A into B
        merge_sort_rec(arr_a, lo, mid, arr_b)

        # Sort the right half (midpoint to high - 1) from A into B
        merge_sort_rec(arr_a, mid, hi, arr_b)

        # Merge the two halves from B into A
        merge(arr_b, lo, mid, hi, arr_a)
    }
}

function merge(arr_b, lo, mid, hi, arr_a,  i, j, k) {
    i = lo
    j = mid

    # While there are elements in the left or right
    for (k = lo; k < hi; k++) {
        # Copy the side that has the next largest value (or next available value if
        # out of values) from the A into B
        if (i < mid && (j >= hi || arr_a[i] <= arr_a[j])) {
            arr_b[k] = arr_a[i]
            i++
        } else {
            arr_b[k] = arr_a[j]
            j++
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

    merge_sort(arr, arr_len)
    show_array(arr)
}
