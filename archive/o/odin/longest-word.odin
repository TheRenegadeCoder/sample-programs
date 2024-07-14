package main

import "core:fmt"
import "core:strings"
import "core:os"

main :: proc() {
    if len(os.args) != 2 {
        usage()
        return
    }
    text := os.args[1]
    get_longest_word(text)
}

get_longest_word :: proc (word: string) -> int {
    if len(strings.trim(word, "\t\r\n ")) == 0 {
        usage()
        return 0
    }
    string_split := strings.split(word, " ", context.allocator)

    count := 0
    for word in string_split {
        if len(strings.trim(word, "\t\r\n ")) > count {
            count = len(strings.trim(word, "\t\r\n ")) 
        }
    }
    fmt.println(count)
    return count
}

usage :: proc() {
    fmt.eprintln("Usage: please input a string")
}