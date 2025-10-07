#!/usr/bin/env tclsh

proc usage {} {
    puts stderr "Usage: please provide a mode and a string to encode/decode"
    exit 1
}

if {$argc != 2} {
    usage
}

set mode [lindex $argv 0]
set text [lindex $argv 1]

if {$text eq ""} {
    usage
}


switch -- $mode {
    encode {
        set result [binary encode base64 $text]
    }
    decode {
        if {[catch {binary decode base64 $text} result]} {
            usage
        }
	# Tcl’s decoder sometimes tolerates invalid padding, so validate manually
        # Check that input length is a multiple of 4 and only contains valid chars
        if {![regexp {^[A-Za-z0-9+/]*={0,2}$} $text]} {
            usage
        }
        if {[expr {[string length $text] % 4 != 0}]} {
            usage
        }
    }
    default {
        usage
    }
}

puts $result

