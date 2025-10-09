package require Tcl 8.6

proc usage {} {
    puts stderr {Usage: please provide a string}
    exit 1
}

proc removeWhitespace {str} {
    regsub -all {\s} $str {} result
    return $result
}

if {$argc != 1} { usage }
set input [lindex $argv 0]
if {$input eq ""} { usage }

puts [removeWhitespace $input]
