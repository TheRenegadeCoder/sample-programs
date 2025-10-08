package require math

proc usage {} {
	puts stderr {Usage: please provide a list of profits and a list of deadlines}
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

proc compareJobs {a b} {
	lassign $a _ aProfit aDeadline
	lassign $b _ bProfit bDeadline

	expr {
		($aProfit > $bProfit) ? -1 :
		($aProfit < $bProfit) ? 1  :
		($aDeadline > $bDeadline) ? -1 :
		($aDeadline < $bDeadline) ? 1  : 0
	}

}

proc jobSequencing {profits deadlines} {
	if {[llength $profits] != [llength $deadlines]} { usage }

	set jobs {}
	for {set i 0} {$i < [llength $profits]} {incr i} {
		set jobId    [expr {$i + 1}]
		set profit   [lindex $profits $i]
		set deadline [lindex $deadlines $i]
		lappend jobs [list $jobId $profit $deadline]
	}

	set jobs [lsort -command compareJobs $jobs]
	set maxDeadline [math::max {*}$deadlines]
	set slots [lrepeat $maxDeadline 0]
	set totalProfit 0

	foreach job $jobs {
		lassign $job jobId profit deadline
		set slotIndex [expr {$deadline - 1}]
		while {$slotIndex >= 0 && [lindex $slots $slotIndex]} {
			incr slotIndex -1
		}
		if {$slotIndex >= 0} {
			lset slots $slotIndex 1
			incr totalProfit $profit
		}
	}
	return $totalProfit
}

if {$argc != 2} {
	usage
}

set profits   [parseList [lindex $argv 0]]
set deadlines [parseList [lindex $argv 1]]

puts [jobSequencing $profits $deadlines]

