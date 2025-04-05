# Reference: https://stackoverflow.com/questions/68371275/how-to-generate-string-with-a-char-repeated-for-n-times
function repeat_string(n, s) {
    result = sprintf("%*s", n, "")
    gsub(" ", s, result)
    return result
}

BEGIN {
    for (i = -10; i <= 10; i++) {
        num_spaces = (i >= 0) ? i : -i
        num_stars = 21 - 2 * num_spaces
        print repeat_string(num_spaces, " ") repeat_string(num_stars, "*")
    }
}
