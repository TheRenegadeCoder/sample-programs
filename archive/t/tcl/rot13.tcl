
proc usage {} {
    puts "Usage: please provide a string to encrypt"
    exit 1
}

if {$argc != 1} { usage }
set input [lindex $argv 0]
if {$input eq ""} { usage }

proc rot13 {text} {
    set upper "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    set lower "abcdefghijklmnopqrstuvwxyz"

    set map {}

    for {set i 0} {$i < 26} {incr i} {
        lappend map [string index $upper $i] [string index $upper [expr {($i+13)%26}]]
        lappend map [string index $lower $i] [string index $lower [expr {($i+13)%26}]]
    }

    return [string map $map $text]
}

puts [rot13 $input]

