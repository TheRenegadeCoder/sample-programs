proc usage {} {
    puts "Usage: please input a non-negative integer"
    exit 1
}

if {$argc != 1} { usage }

set n [lindex $argv 0]
if {![string is integer -strict $n] || $n < 0} { usage }

proc factorial {n} {
    set result 1
    for {set i 1} {$i <= $n} {incr i} {
        set result [expr {$result * $i}]
    }
    return $result
}

puts [factorial $n]
