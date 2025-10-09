package require Tcl 8.6

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

proc sleepSort {lst} {
    set ::sortedList {}
    set ::done 0

    foreach num $lst {
        after [expr {$num * 10}] [list lappend ::sortedList $num]
    }

    set max [lindex $lst 0]
    foreach n $lst {if {$n > $max} {set max $n}}

    after [expr {$max * 10 + 50}] {set ::done 1}
    vwait ::done

    return $::sortedList
}

proc formatList {lst} { return [join $lst ", "] }

if {$argc != 1} { usage }

set numbers [parseList [lindex $argv 0]]
set result [sleepSort $numbers]
puts [formatList $result]

