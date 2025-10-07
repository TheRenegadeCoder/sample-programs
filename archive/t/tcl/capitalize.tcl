proc usage {} {
	puts stderr {Usage: please provide a string}
	exit 1
}

if {$argc < 1} { usage }

set buf [string trim [lindex $argv 0]]
if {$buf eq ""} { usage }

set first [string toupper [string index $buf 0]]
set rest [string range $buf 1 end]
puts "${first}${rest}"
