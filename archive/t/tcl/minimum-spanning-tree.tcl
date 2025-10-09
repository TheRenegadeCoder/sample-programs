package require Tcl 8.6
package require struct::graph
package require struct::graph::op

proc usage {} {
	puts stderr {Usage: please provide a comma-separated list of integers}
	exit 1
}

proc isInteger {x} { return [string is integer -strict $x] }

proc parseList {s} {
	set s [string trim $s]
	if {$s eq ""} { usage }

	set result {}
	foreach t [split $s ,] {
		set t [string trim $t]
		if {![isInteger $t] || $t < 0} { usage }
		lappend result $t
	}
	return $result
}

proc range {start end} {
	set result {}
	for {set i $start} {$i <= $end} {incr i} { lappend result $i }
	return $result
}

proc createGraph {matrix} {
	set n [expr {int(sqrt([llength $matrix]))}]
	if {$n * $n != [llength $matrix]} { usage }

	set g [::struct::graph]
	$g node insert {*}[range 0 [expr {$n-1}]]

	set idx 0
	for {set i 0} {$i < $n} {incr i} {
		for {set j 0} {$j < $n} {incr j} {
			set w [lindex $matrix $idx]
			incr idx
			if {$w > 0} { 
				$g arc setweight [$g arc insert $i $j] $w 
			}
		}
	}
	return $g
}

if {[llength $argv] != 1} { usage }
set matrixStr [lindex $argv 0]

set matrix [parseList $matrixStr]
set g [createGraph $matrix]

try {
	set mst [::struct::graph::op::prim $g]
	set arcWeights [$g arc weights]

	set totalWeight 0
	foreach a $mst {
		incr totalWeight [dict get $arcWeights $a]
	}

	puts $totalWeight
} on error {err opts} {
	usage
} finally {
	$g destroy
}

