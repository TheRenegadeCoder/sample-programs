package require Tcl 8.6
package require struct::matrix

proc usage {} {
	puts stderr {Usage: please enter the dimension of the matrix and the serialized matrix}
	exit 1
}

if {$argc != 3} { usage }
set cols [lindex $argv 0]
set rows [lindex $argv 1]
set matrixStr [lindex $argv 2]

if {$cols eq "" || $rows eq "" || $matrixStr eq ""} { usage }

if {![string is integer -strict $cols] || ![string is integer -strict $rows]} {
    usage
}

set values [lmap v [split $matrixStr ","] {string trim $v}]
if {[llength $values] != $cols * $rows} { usage }

set m [struct::matrix]
$m add columns $cols
$m add rows $rows

for {set r 0} {$r < $rows} {incr r} {
	set start [expr {$r*$cols}]
	set end [expr {($r+1)*$cols - 1}]
	$m set row $r [lrange $values $start $end]
}

$m transpose

set outList {}
for {set i 0} {$i < $cols} {incr i} {
    lappend outList {*}[$m get row $i]
}

puts [join $outList ", "]

