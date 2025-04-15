function repeat_string(n, s,  result, k) {
    result = ""
    for (k = 1; k <= n; k++) {
        result = result s
    }

    return result
}

BEGIN {
    for (i = -10; i <= 10; i++) {
        num_spaces = (i >= 0) ? i : -i
        num_stars = 21 - 2 * num_spaces
        print repeat_string(num_spaces, " ") repeat_string(num_stars, "*")
    }
}
