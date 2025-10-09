proc usage {} {
    puts stderr {Usage: please input the total number of people and number of people to skip.}
    exit 1
}

proc parseInt {s} {
    set s [string trim $s]
    if {[string is integer -strict $s]} { return $s }
    usage
}

proc josephus {total skip} {
    if {$skip < 1 || $total < 1} { usage }

    # If skip = 1, survivor is the last person
    if {$skip == 1} { return $total }

    # Optimized case for skip = 2
    if {$skip == 2} {
        set power 1
        while {($power << 1) <= $total} {
            set power [expr {$power << 1}]
        }
        return [expr {2 * ($total - $power) + 1}]
    }

    set result 0
    for {set i 2} {$i <= $total} {incr i} {
        set result [expr {($result + $skip) % $i}]
    }

    return [expr {$result + 1}]
}

if {$argc != 2} { usage }

set total [parseInt [lindex $argv 0]]
set skip  [parseInt [lindex $argv 1]]

puts [josephus $total $skip]
