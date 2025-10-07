proc usage {} {
    puts "Usage: please input a number"
    exit 1
}

if {$argc != 1} {
    usage
}

set arg [lindex $argv 0]

if {![string is integer -strict $arg]} {
    usage
}

set num [expr {$arg + 0}]
puts [expr {$num % 2 == 0 ? "Even" : "Odd"}] 
