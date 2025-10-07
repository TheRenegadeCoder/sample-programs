proc usage {} {
    puts stderr {Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210")}
    exit 1
}

proc parseList {s} {
    set s [string trim $s]
    if {$s eq ""} {
        usage
    }

    set tokens [split $s ","]
    set result {}

    foreach token $tokens {
        set t [string trim $token]
        if {![string is integer -strict $token]} { usage }
        lappend result [expr {$token}]
    }

    if {[llength $result] < 3} { usage }
    return $result
}

if {$argc != 2} { usage }

set xs [parseList [lindex $argv 0]]
set ys [parseList [lindex $argv 1]]

if {[llength $xs] != [llength $ys]} { usage }

set points {}
for {set i 0} {$i < [llength $xs]} {incr i} {
    lappend points [list [lindex $xs $i] [lindex $ys $i]]
}

proc cross {a b c} {
    set x1 [expr {[lindex $b 0] - [lindex $a 0]}]
    set y1 [expr {[lindex $b 1] - [lindex $a 1]}]
    set x2 [expr {[lindex $c 0] - [lindex $a 0]}]
    set y2 [expr {[lindex $c 1] - [lindex $a 1]}]
    return [expr {$x1 * $y2 - $y1 * $x2}]
}

proc pointCompare {a b} {
    if {[lindex $a 0] < [lindex $b 0]} { return -1 }
    if {[lindex $a 0] > [lindex $b 0]} { return 1 }
    if {[lindex $a 1] < [lindex $b 1]} { return -1 }
    if {[lindex $a 1] > [lindex $b 1]} { return 1 }
    return 0
}

proc convexHull {points} {
    set n [llength $points]
    if {$n < 3} { return $points }

    set sorted [lsort -command pointCompare $points]

    set lower {}
    foreach p $sorted {
        while {[llength $lower] >= 2} {
            set q [lindex $lower end-1]
            set r [lindex $lower end]
            if {[cross $q $r $p] > 0} { break }
            set lower [lrange $lower 0 end-1]
        }
        lappend lower $p
    }

    set upper {}
    foreach p [lreverse $sorted] {
        while {[llength $upper] >= 2} {
            set q [lindex $upper end-1]
            set r [lindex $upper end]
            if {[cross $q $r $p] > 0} { break }
            set upper [lrange $upper 0 end-1]
        }
        lappend upper $p
    }

    set hull [concat [lrange $lower 0 end-1] [lrange $upper 0 end-1]]
    return $hull
}

set hull [convexHull $points]

foreach pt $hull {
    set x [string trim [lindex $pt 0]]
    set y [string trim [lindex $pt 1]]
    puts "($x, $y)"
}

