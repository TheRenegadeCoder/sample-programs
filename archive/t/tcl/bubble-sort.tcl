proc usage {} {
	puts stderr {Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"}
	exit 1
}

proc parseIntegerList {s} {
	set s [string trim $s]
	if {$s eq ""} {
		usage
	}

	set tokens [split $s ","]
	set result {}

	foreach token $tokens {
		set t [string trim $token]
		if {$t eq ""} {			
			usage
		}
		if {[catch {expr {int($t)}} val]} { 
			usage
		}
		lappend result $val
	}

	if {[llength $result] < 2} {
		usage
	}
	return $result
}

proc isSorted {lst} {
	set len [llength $lst]
	if {$len <= 1} { return 1 }
	for {set i 1} {$i < $len} {incr i} {
		if {[lindex $lst $i] < [lindex $lst [expr {$i - 1}]]} {
			return 0
		}
	}
	return 1
}

proc bubbleSort {lstVar} {
    upvar 1 $lstVar lst
    set n [llength $lst]
    for {set i [expr {$n - 1}]} {$i > 0} {incr i -1} {
        set swapped 0
        for {set j 0} {$j < $i} {incr j} {
            set a [lindex $lst $j]
            set b [lindex $lst [expr {$j + 1}]]
            if {$a > $b} {
                # swap elements
                lset lst $j $b
                lset lst [expr {$j + 1}] $a
                set swapped 1
            }
        }
        if {!$swapped} {
            break
        }
    }
}

proc formatList {lst} {
    set out ""
    set n [llength $lst]
    for {set i 0} {$i < $n} {incr i} {
        if {$i > 0} { append out ", " }
        append out [lindex $lst $i]
    }
    return $out
}

if {$argc != 1} {
	usage
}

set raw [lindex $argv 0]
set numbers [parseIntegerList $raw]

if {![isSorted $numbers]} {
    bubbleSort numbers
}

puts [formatList $numbers]
