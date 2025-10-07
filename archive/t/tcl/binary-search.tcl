proc usage {} {
	puts stderr {Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")}
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

	if {[llength $result] == 0} {
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

proc binarySearch {lst value} {
	set len [llength $lst]
	if {$len == 0} { return 0 }
	if {$len == 1} {
		return [expr {[lindex $lst 0] == $value}]
	}

	# Since binary search assumes a sorted list, if the value isn't within
	# the range of the values inside the list, there's no need to even start
	# the algorithm.
	set first [lindex $lst 0]
	set last  [lindex $lst end]
	if {$value < $first || $value > $last} { return 0 }

	set left 0
	set right [expr {$len - 1}]

	while {$left <= $right} {
		set mid [expr {$left + (($right - $left) / 2)}]
		set pivot [lindex $lst $mid]

		if {$pivot == $value} {
			return 1
		} elseif {$pivot < $value} {
			set left [expr {$mid + 1}]
		} else {
			set right [expr {$mid - 1}]
		}
	}
	return 0
}

if {$argc != 2} {
	usage
}

set listArg [string trim [lindex $argv 0]]
set valueArg [string trim [lindex $argv 1]]

if {$listArg eq "" || $valueArg eq ""} {
	usage
}

set numbers [parseIntegerList $listArg]

if {![isSorted $numbers]} {
	usage
}

if {[catch {expr {int($valueArg)}} value]} {
	usage
}

puts [expr {[binarySearch $numbers $value] ? "true" : "false"}]
