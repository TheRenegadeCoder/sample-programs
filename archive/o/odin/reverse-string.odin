package main

import "core:fmt"
import "core:strings"
import "core:os"

reverse_string :: proc(str : string) {
    sb := strings.builder_make(0, len(str))
    #reverse for ch in str {
        strings.write_rune(&sb, ch)
    }
    fmt.println(strings.to_string(sb))
}

usage :: proc () {
    fmt.eprintln("Usage: please input a string")
}

main :: proc() {
    if len(os.args) < 2 {
        usage()
        return
    }
    reverse_string(os.args[1])
}