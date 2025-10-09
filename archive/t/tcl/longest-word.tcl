proc usage {} {
	puts stderr {Usage: please provide a string}
	exit 1
}

proc longestWordLength {s} {
	set s [string trim $s]
	if {$s eq ""} { usage }

	set maxLen 0
	set curLen 0
	set len [string length $s]

	for {set i 0} {$i < $len} {incr i} {
		set ch [string index $s $i]
		if {[string is space $ch]} {
			if {$curLen > $maxLen} { set maxLen $curLen }
			set curLen 0
		} else {
			incr curLen
		}
	}

	if {$curLen > $maxLen} { set maxLen $curLen }

	return $maxLen
}

if {$argc != 1} { usage }

set input [lindex $argv 0]
if {[string trim $input] eq ""} { usage }

puts [longestWordLength $input]
