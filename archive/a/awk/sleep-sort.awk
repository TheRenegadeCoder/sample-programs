@load "time"

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

# Awk does not have threads. However, it does have a functions to get the
# current system time and sleep with fractions of a second precision. Use those
# to monitor the elapsed time, and use that to sort the array
function sleep_sort(arr, arr_len,  curr_time, start_time, elapsed_time, i, t, num_sorted) {
    # Get initial time
    start_time = gettimeofday()

    # Indicate no sorted elements yet
    num_sorted = 0

    # Repeat unit array is sorted
    while (num_sorted < arr_len) {
        # When elapsed time for array element expires, swap it from the unsorted to the
        # sorted part of the array
        elapsed_time = gettimeofday() - start_time
        for (i = num_sorted + 1; i <= arr_len; i++) {
            if (elapsed_time >= arr[i]) {
                num_sorted++
                t = arr[i]
                arr[i] = arr[num_sorted]
                arr[num_sorted] = t
            }
        }

        sleep(0.5)
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

    sleep_sort(arr, arr_len)
    show_array(arr)
}
