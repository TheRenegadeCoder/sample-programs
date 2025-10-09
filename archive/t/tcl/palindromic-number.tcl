package require Tcl 8.6

proc usage {} {
    puts stderr "Usage: please input a non-negative integer"
    exit 1
}

proc isNonNegativeInteger {s} { return [regexp {^[0-9]+$} $s] }


proc isPalindrome {s} {
    set n [string length $s]
    set i 0
    set j [expr {$n - 1}]
    while {$i < $j} {
        if {[string range $s $i $i] ne [string range $s $j $j]} {
            return 0
        }
        incr i
        incr j -1
    }
    return 1
}

if {$argc != 1} { usage }

set input [string trim [lindex $argv 0]]
if {![isNonNegativeInteger $input]} { usage }

puts [expr {[isPalindrome $input] ? "true" : "false"}]
