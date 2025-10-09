proc usage {} {
	puts stderr {Usage: please provide a list of integers (e.g. "8, 3, 1, 2")}
	exit 1
}

proc parseList {s} {
	set tokens [split [string trim $s] ","]
	if {[llength $tokens] < 1} { usage }

	set result {}

	set result {}
	foreach token $tokens {
		set t [string trim $token]
		if {$t eq "" || [catch {expr {int($t)}} val]} usage
		lappend result $val
	}
	return $result
}

proc maximumRotationSum {numbers} {
	set n [llength $numbers]
	if {$n == 0} { usage }

	set totalSum 0
	set currentSum 0
	for {set i 0} {$i < $n} {incr i} {
		set val [lindex $numbers $i]
		incr totalSum $val
		incr currentSum [expr {$val * $i}]
	}

	set maxSum $currentSum

	for {set i 1} {$i < $n} {incr i} {
		set rotatedVal [lindex $numbers [expr {$n - $i}]]
		set currentSum [expr {$currentSum + $totalSum - $n * $rotatedVal}]
		if {$currentSum > $maxSum} { set maxSum $currentSum }
	}

	return $maxSum
}

if {$argc != 1} { usage }

set numbers [parseList [lindex $argv 0]]
puts [maximumRotationSum $numbers]
