package require Tcl 8.6

if {$argc != 1} { exit }

set input [lindex $argv 0]
if {$input eq ""} { exit }

puts [join [lreverse [split $input ""]] ""]

