proc usage {} {
    puts stderr {Usage: please provide a string that contains at least one palindrome}
    exit 1
}

proc longestPalindromicSubstring {s} {
    if {$s eq ""} { return "" }

    set processed "#[join [split $s ""] #]#"
    set n [string length $processed]
    set p [lrepeat $n 0]

    set center 0
    set right 0
    set maxLen 0
    set maxCenter 0

    for {set i 0} {$i < $n} {incr i} {
        set mirror [expr {2 * $center - $i}]
        if {$i < $right} {
            lset p $i [expr {min($right - $i, [lindex $p $mirror])}]
        }

        while {
            ($i + [lindex $p $i] + 1) < $n &&
            ($i - [lindex $p $i] - 1) >= 0 &&
            [string index $processed [expr {$i + [lindex $p $i] + 1}]] eq \
            [string index $processed [expr {$i - [lindex $p $i] - 1}]]
        } {
            lset p $i [expr {[lindex $p $i] + 1}]
        }

        if {$i + [lindex $p $i] > $right} {
            set center $i
            set right [expr {$i + [lindex $p $i]}]
        }

        if {[lindex $p $i] > $maxLen} {
            set maxLen [lindex $p $i]
            set maxCenter $i
        }
    }

    set start [expr {($maxCenter - $maxLen) / 2}]

    return [string range $s $start [expr {$start + $maxLen - 1}]]
}

if {$argc != 1} { usage }

set input [string trim [lindex $argv 0]]
if {$input eq ""} { usage }

set result [longestPalindromicSubstring $input]
if {[string length $result] <= 1} { usage } 

puts $result

