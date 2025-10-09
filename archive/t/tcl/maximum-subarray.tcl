proc usage {} {
	puts stderr {Usage: Please provide a list of integers in the format: "1, 2, 3, 4, 5"}
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

proc maximumSubarraySum {numbers} {
    if {[llength $numbers] == 0} { return 0 }

    set currentSum [lindex $numbers 0]
    set maxSum $currentSum

    for {set i 1} {$i < [llength $numbers]} {incr i} {
        set val [lindex $numbers $i]
        set currentSum [expr {max($val, $currentSum + $val)}]
        set maxSum [expr {max($maxSum, $currentSum)}]
    }

    return $maxSum
}

if {$argc != 1} { usage }

set numbers [parseList [lindex $argv 0]]
puts [maximumSubarraySum $numbers]
