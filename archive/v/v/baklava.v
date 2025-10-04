module main

fn str_repeat(n int, s string) string {
    mut result := ""
    for _ in 0 .. n {
        result += s
    }

    return result
}

fn main() {
    for i in -10 .. 11 {
        num_spaces := if i >= 0 { i } else { -i }
        println(str_repeat(num_spaces, " ") + str_repeat(21 - 2 *num_spaces, "*"))
    }
}
