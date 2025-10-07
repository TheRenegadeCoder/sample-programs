proc usage {} {
    puts "Usage: please input the count of fibonacci numbers to output"
    exit 1
}

if {$argc != 1} { usage }

set arg [lindex $argv 0]
if {![string is integer -strict $arg] || $arg < 0} { usage }

set count $arg

set first 0
set second 1

for {set i 1} {$i <= $count} {incr i} {
    set result [expr {$first + $second}]
    set first $second
    set second $result
    puts "$i: $first"
}

