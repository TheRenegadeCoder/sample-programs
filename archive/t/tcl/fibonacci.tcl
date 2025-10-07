proc usage {} {
    puts "Usage: please input the count of fibonacci numbers to output"
    exit 1
}

if {$argc != 1} { usage }

set count [lindex $argv 0]

if {![string is integer -strict $count] || $count < 0} { usage }

set a 1
set b 1

for {set i 1} {$i <= $count} {incr i} {
    puts "$i: $a"

    set next [expr {$a + $b}]
    set a $b
    set b $next
}
