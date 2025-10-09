proc usage {} {
	puts stderr {Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")}
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


proc parseInt {s} {
	set s [string trim $s]
	if {$s eq "" || [catch {expr {int($s)}} val]} {
		usage
	}
	return $val
}

proc linearSearch {nums value} {
	expr {[lsearch -integer -exact $nums $value] != -1}
}

if {$argc != 2} { usage }

set numbers [parseList [lindex $argv 0]]
set key     [parseInt  [lindex $argv 1]]

set found [linearSearch $numbers $key]
puts [expr {$found ? "true" : "false"}]

