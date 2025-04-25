function usage() {
    print "Usage: please enter the dimension of the matrix and the serialized matrix"
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

function arr_to_matrix(arr, num_rows, num_cols, matrix,  idx, i, j) {
    idx = 0
    for (i = 1; i <= num_rows; i++) {
        for (j = 1; j <= num_cols; j++) {
            matrix[i, j] = arr[++idx]
        }
    }
}

function transpose_matrix(matrix, num_rows, num_cols, t_matrix,  i, j) {
    for (i = 1; i <= num_rows; i++) {
        for (j = 1; j <= num_cols; j++) {
            t_matrix[j, i] = matrix[i, j]
        }
    }
}

function matrix_to_arr(matrix, num_rows, num_cols, arr,  idx, i, j) {
    idx = 0
    for (i = 1; i <= num_rows; i++) {
        for (j = 1; j <= num_cols; j++) {
            arr[++idx] = matrix[i, j]
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
    if (ARGC < 4) {
        usage()
    }

    num_cols = str_to_number(ARGV[1])
    num_rows = str_to_number(ARGV[2])
    str_to_array(ARGV[3], arr)
    arr_len = length(arr)
    if (num_cols == "ERROR" || num_rows == "ERROR" || \
        !arr_len || arr[1] == "ERROR" || \
        num_cols * num_rows != arr_len) {
        usage()
    }

    arr_to_matrix(arr, num_rows, num_cols, matrix)
    transpose_matrix(matrix, num_rows, num_cols, t_matrix)
    matrix_to_arr(t_matrix, num_cols, num_rows, arr)
    show_array(arr)
}
