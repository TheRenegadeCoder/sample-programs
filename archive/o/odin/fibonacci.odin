package main

import "core:fmt"
import "core:strconv"
import "core:os"

main :: proc() {
    if len(os.args) != 2 {
        usage()
        return
    }
    input, check := strconv.parse_int(os.args[1], 10)
    if !check {
        usage()
        return
    }

    use1 := 0
    use2 := 1
    use3 := 0
    for i:=1 ; i <= input; i += 1 {
        use3 = use1 + use2
        use1 = use2
        use2 = use3
        fmt.print(i)
        fmt.print(": ")
        fmt.println(use1)
    }
}

usage :: proc() { 
    fmt.println("Usage: please input the count of fibonacci numbers to output")
}
