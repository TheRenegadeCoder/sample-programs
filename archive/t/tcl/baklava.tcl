for {set i -10} {$i <= 10} {incr i} {
    set numSpaces [expr { abs($i) }]
    set numStars [expr 21 - 2 * $numSpaces]
    puts "[string repeat { } $numSpaces][string repeat * $numStars]"
}
