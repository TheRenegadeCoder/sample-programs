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

# Source: https://en.wikipedia.org/wiki/Quicksort#Lomuto_partition_scheme
function quick_sort(arr, arr_len) {
    quick_sort_rec(arr, 1, arr_len)
}

function quick_sort_rec(arr, lo, hi,  p) {
    if (lo < hi && lo >= 1) {
        # Partition array and get pivot value
        p = partition(arr, lo, hi)

        # Sort left side of partition
        quick_sort_rec(arr, lo, p - 1)

        # Sort right side of partition
        quick_sort_rec(arr, p + 1, hi)
    }
}

function partition(arr, lo, hi,  i, j, pivot) {
    # Choose last value as pivot
    pivot = arr[hi]
    
    # Set temporary pivot index
    i = lo - 1

    # Swap elements less than or equal to pivot, and increment temporary index
    for (j = lo; j < hi; j++) {
        if (arr[j] <= pivot) {
            i++
            swap(arr, i, j)
        }
    }

    # Move pivot to correct position
    i++
    swap(arr, i, hi)

    return i
}

function swap(arr, i, j,  t) {
    t = arr[i]
    arr[i] = arr[j]
    arr[j] = t
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

    quick_sort(arr, arr_len)
    show_array(arr)
}
