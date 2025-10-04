function usage() {
    print "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"
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

function linear_search(arr, target,  result, idx) {
    result = 0
    for (idx in arr) {
        if (arr[idx] == target) {
            result = idx
            break
        }
    }

    return result
}

BEGIN {
    if (ARGC < 3) {
        usage()
    }

    str_to_array(ARGV[1], arr)
    target = str_to_number(ARGV[2])
    if (!length(arr) || arr[1] == "ERROR" || target == "ERROR") {
        usage()
    }

    idx = linear_search(arr, target)
    print (idx > 0) ? "true" : "false"
}
