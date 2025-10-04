fun repeat_string(s : string, n : int) {
    var result := ""
    list(1, n).foreach(fn(_) { result := result + s })
    result
}

fun main() {
    list(-10, 10).foreach(fn(n) {
        var num_spaces := abs(n)
        var num_stars := 21 - 2 * num_spaces
        println(repeat_string(" ", num_spaces) + repeat_string("*", num_stars))
    })
}
