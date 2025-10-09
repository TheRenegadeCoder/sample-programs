proc usage {} {
	puts stderr {Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"}
	exit 1
}

proc parseList {s} {
	set tokens [split [string trim $s] ","]
	if {[llength $tokens] < 2} { usage }

	set result {}
	foreach token $tokens {
		set t [string trim $token]
		if {$t eq "" || [catch {expr {int($t)}} val]} usage
		lappend result $val
	}
	return $result
}

proc merge {lstVar tempVar left mid right} {
	upvar 1 $lstVar lst
	upvar 1 $tempVar temp

	set i $left
	set j [expr {$mid + 1}]
	set k $left

	while {$i <= $mid && $j <= $right} {
		if {[lindex $lst $i] <= [lindex $lst $j]} {
			lset temp $k [lindex $lst $i]
			incr i
		} else {
			lset temp $k [lindex $lst $j]
			incr j
		}
		incr k
	}

	while {$i <= $mid} {
		lset temp $k [lindex $lst $i]
		incr i
		incr k
	}

	while {$j <= $right} {
		lset temp $k [lindex $lst $j]
		incr j
		incr k
	}

	for {set idx $left} {$idx <= $right} {incr idx} {
		lset lst $idx [lindex $temp $idx]
	}
}

proc mergeSort {lstVar} {
	upvar 1 $lstVar lst
	set n [llength $lst]
	if {$n <= 1} { return }

	set temp {}
	set width 1
	while {$width < $n} {
		set i 0
		while {$i < $n} {
			set left $i
			set mid [expr {$i + $width - 1}]
			if {$mid >= $n} { break }

			set right [expr {$mid + $width}]
			if {$right >= $n} { set right [expr {$n - 1}] }

			merge lst temp $left $mid $right
			incr i [expr {2 * $width}]
		}
		set width [expr {$width * 2}]
	}
}

proc formatList {lst} { return [join $lst ", "] }

if {$argc != 1} { usage }

set numbers [parseList [lindex $argv 0]]
mergeSort numbers
puts [formatList $numbers]

