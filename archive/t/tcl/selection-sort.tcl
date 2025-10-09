proc usage {} {
	puts stderr {Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"}
	exit 1
}

proc parseList {s} {
	set tokens [split [string trim $s] ","]
	if {[llength $tokens] < 2} { usage }

	set result {}

	set result {}
	foreach token $tokens {
		set t [string trim $token]
		if {$t eq "" || [catch {expr {int($t)}} val]} usage
		lappend result $val
	}
	return $result
}

proc isSorted {lst} {
	set prev [lindex $lst 0]
	foreach x [lrange $lst 1 end] {
		if {$x < $prev} {return 0}
		set prev $x
	}
	return 1
}

proc selectionSort {lstVar} {
    upvar 1 $lstVar lst
    set n [llength $lst]

    for {set i 0} {$i < $n - 1} {incr i} {
        set minIdx $i
        for {set j [expr {$i + 1}]} {$j < $n} {incr j} {
            if {[lindex $lst $j] < [lindex $lst $minIdx]} {
                set minIdx $j
            }
        }
        if {$minIdx != $i} {
            set temp [lindex $lst $i]
            lset lst $i [lindex $lst $minIdx]
            lset lst $minIdx $temp
        }
    }
}

proc formatList {lst} { return [join $lst ", "] }

if {$argc != 1} { usage }

set numbers [parseList [lindex $argv 0]]

if {![isSorted $numbers]} {
    selectionSort numbers
}

puts [formatList $numbers]
