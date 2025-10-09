package require Tcl 8.6
package require math::numtheory

proc usage {} {
    puts stderr {Usage: please input a non-negative integer}
    exit 1
}

proc isNonNegativeInteger {s} {
    if {[catch {expr {int($s)}} n]} {
        return 0
    }
    if {$s eq ""} { return 0 }
    if {![string is integer -strict $s]} {
        return 0
    }
    return [expr {$n >= 0}]
}

if {$argc != 1} { usage }

set input [string trim [lindex $argv 0]]
if {![isNonNegativeInteger $input]} { usage }

set n $input
if {$n < 2} {
    puts "composite"
} elseif {[math::numtheory::isprime $n]} {
    puts "prime"
} else {
    puts "composite"
}

