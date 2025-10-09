package require Tcl 8.6
package require math::roman

proc usage {msg} {
    puts $msg
    exit 1
}

if {$argc != 1} { usage "Usage: please provide a string of roman numerals" }

set input [string trim [lindex $argv 0]]

if {$input eq ""} {
    puts 0
    exit 0
}

if {[catch {math::roman::tointeger $input} err]} {
    usage "Error: invalid string of roman numerals"
} else {
    puts [math::roman::tointeger $input]
}
