proc usage {} {
	puts "Usage: please input a non-negative integer"
    exit 1
}

proc zeckendorf {n} {
    set result {}
    set a 1
    set b 2

    while {$b <= $n} {
        lassign [list $b [expr {$a + $b}]] a b
    }

    while {$n > 0} {
        if {$a <= $n} {
            set n [expr {$n - $a}]
            lappend result $a
        }
        lassign [list [expr {$b - $a}] $a] a b
    }

    return $result
}

if {$argc != 1} { usage }
lassign $argv arg

if {![string is integer -strict $arg] || $arg < 0} {
    usage
}

puts [join [zeckendorf $arg] ", "]