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

proc insertionSort {lstVar} {
    upvar 1 $lstVar lst
    set n [llength $lst]
    if {$n <= 1} {return}

    set findInsertPos [list {lst key high} {
        set low 0
        incr high -1
        while {$low <= $high} {
            set mid [expr {($low + $high) / 2}]
            if {[lindex $lst $mid] < $key} {
                incr low
            } else {
		incr high -1
	    }
        }
        return $low
    }]

    for {set i 1} {$i < $n} {incr i} {
        set key [lindex $lst $i]

        if {$key >= [lindex $lst [expr {$i - 1}]]} {
            continue
        }

        set pos [apply $findInsertPos $lst $key $i]

        set before [lrange $lst 0 [expr {$pos - 1}]]
        set middle [list $key]
        set after [lrange $lst $pos [expr {$i - 1}]]
        set rest [lrange $lst [expr {$i + 1}] end]

        set lst [concat $before $middle $after $rest]
    }
}

proc formatList {lst} { return [join $lst ", "] }

if {$argc != 1} { usage }

set numbers [parseList [lindex $argv 0]]

if {![isSorted $numbers]} {
    insertionSort numbers
}

puts [formatList $numbers]
