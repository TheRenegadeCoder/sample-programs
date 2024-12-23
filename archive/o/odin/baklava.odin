package main;

import "core:fmt"
import "core:strings"

main :: proc() {
    for i := -10; i <= 10; i += 1 {
        num_spaces := abs(i)
        num_stars := 21 - 2 * num_spaces
        spaces, _ := strings.repeat(" ", num_spaces)
        stars, _ := strings.repeat("*", num_stars)
        fmt.println(strings.concatenate({spaces, stars}))
    }
}
