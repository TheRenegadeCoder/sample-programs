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

get_longest_word :: proc (words: string) -> int {
    if len(words) == 0 {
        usage()
        return 0
    }

    cleaned, _ := strings.replace_all(words, "\t", " ")
    cleaned, _ = strings.replace_all(cleaned, "\r", " ")
    cleaned, _ = strings.replace_all(cleaned, "\n", " ")
    string_split := strings.split(cleaned, " ")

    count := 0
    for word in string_split {
        if len(word) > count {
            count = len(word)
        }
    }
    fmt.println(count)
    return count
}

usage :: proc() {
    fmt.eprintln("Usage: please provide a string")
}
