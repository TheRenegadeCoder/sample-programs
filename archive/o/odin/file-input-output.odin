package main

import "core:os"
import "core:fmt"
import "core:strings"

read_file :: proc(filepath: string) {
    data, ok := os.read_entire_file(filepath, context.allocator) // context.allocator will track the memory held by this data
    if !ok {
        fmt.println("Error reading file")
    }
    defer delete(data, context.allocator) // we're using the allocator to delete the memory. defer means 'execute this code when the function returns'
    it := string(data)
    for line in strings.split_lines_iterator(&it) { // run through all the lines
        fmt.println(line)
    }
}

write_file :: proc(filepath: string) {
    data_as_string := "Odin is great!"
    data_as_bytes := transmute([]byte)(data_as_string) // 'transmute' casts our string to a byte array
    ok := os.write_entire_file(filepath, data_as_bytes)
    if !ok {
        fmt.println("Error writing file")
    }
}

main :: proc() {
    
    write_file("output.txt")
    read_file("output.txt")
}