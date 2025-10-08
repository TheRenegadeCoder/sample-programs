# This approach is exclusively to show the capabilities and flexibility of Tcl.
# It doesn't deserve being this overengineered in the normal case. :P

proc fizzbuzz {rules {limit 100}} {
	namespace eval ::fizzbuzz {
		namespace export *
		namespace ensemble create
	}

	foreach {div word} $rules {
		proc ::fizzbuzz::$word {n} [format {
			expr {($n %% %d) == 0 ? "%s" : ""}
		} $div $word]
	}

	for {set n 1} {$n <= $limit} {incr n} {
		set s ""
		foreach {div word} $rules {
			append s [::fizzbuzz::$word $n]
		}
		puts [expr {$s eq "" ? $n : $s}]
	}
}

fizzbuzz {3 Fizz 5 Buzz}
