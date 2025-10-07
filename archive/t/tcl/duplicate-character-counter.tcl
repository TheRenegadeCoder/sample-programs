proc usage {} {
	puts stderr "Usage: please provide a string"
	exit 1
}

proc countDuplicates {str} {
	if {$str eq ""} { usage }

	set counts [dict create]
	set order {}

	foreach ch [split $str {}] {
		if {[string is alnum -strict $ch]} {
			if {![dict exists $counts $ch]} {
				lappend order $ch
			}
			dict incr counts $ch 1
		}
	}

	set printed 0

	foreach ch $order {
		set count [dict get $counts $ch]
		if {$count > 1} {
			puts "$ch: $count"
			incr printed
		}
	}

	if {$printed == 0} {
		puts "No duplicate characters"
	}
}

if {$argc != 1} { usage }
set input [string trim [lindex $argv 0]]
if {$input eq ""} { usage }

countDuplicates $input

