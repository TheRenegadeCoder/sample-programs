package require Tcl 8.6
package require struct::matrix

proc usage {} {
	puts stderr {Usage: please provide two lists in the format "1, 2, 3, 4, 5"}
	exit 1
}

proc parseList {s} {
	set result {}
	foreach t [split $s ","] {
		set t [string trim $t]
		if {$t eq "" || [catch {expr {int($t)}} val]} { usage }
		lappend result $val
	}
	return $result
}

proc formatList {lst} {
	return [join $lst ", "]
}

proc decr {varName {by 1}} {
	upvar 1 $varName v
	set v [expr {$v - $by}]
	return $v
}

proc getCell {matrix i j} {
	set v [eval $matrix get cell $j $i]
	return [expr {($v eq "") ? 0 : $v}]
}

proc longestCommonSubsequence {a b} {
	set n [llength $a]
	set m [llength $b]

	::struct::matrix dp
	dp add rows [expr {$n + 1}]
	dp add columns [expr {$m + 1}]

	for {set row 1} {$row <= $n} {incr row} {
		set valA [lindex $a [expr {$row - 1}]]
		for {set col 1} {$col <= $m} {incr col} {
			set valB [lindex $b [expr {$col - 1}]]
			if {$valA eq $valB} {
				set diag [getCell dp [expr {$row-1}] [expr {$col-1}]]
				dp set cell $col $row [expr {$diag + 1}]
			} else {
				set top  [getCell dp [expr {$row-1}] $col]
				set left [getCell dp $row [expr {$col-1}]]
				dp set cell $col $row [expr {max($top, $left)}]
			}
		}
	}

	set lcs {}
	set row $n
	set col $m
	while {$row > 0 && $col > 0} {
		set valA [lindex $a [expr {$row - 1}]]
		set valB [lindex $b [expr {$col - 1}]]
		set top  [getCell dp [expr {$row-1}] $col]
		set left [getCell dp $row [expr {$col-1}]]

		if {$valA eq $valB} {
			lappend lcs $valA
			decr row; decr col
		} elseif {$top >= $left} {
			decr row
		} else {
			decr col
		}
	}

	return [lreverse $lcs]
}

if {$argc != 2} { usage }

set a [parseList [lindex $argv 0]]
set b [parseList [lindex $argv 1]]

set lcs [longestCommonSubsequence $a $b]

if {[llength $lcs] == 0} {
	puts "No common subsequence."
} else {
	puts [formatList $lcs]
}

