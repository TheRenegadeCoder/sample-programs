package require math

proc usage {} {
    puts "Usage: please input a non-negative integer"
    exit 1
}

if {$argc != 1} { usage }

set n [lindex $argv 0]
if {![string is integer -strict $n] || $n < 0} { usage }

puts [::math::factorial $n]
