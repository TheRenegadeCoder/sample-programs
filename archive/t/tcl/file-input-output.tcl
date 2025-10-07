#!/usr/bin/env tclsh

proc writeToFile {filename} {
    if {[catch {set fh [open $filename w]} err]} {
        puts "Error opening file for writing \"$filename\": $err"
        return 1
    }

    if {[catch {
        puts $fh "A line of text"
        puts $fh "Another line of text"
        flush $fh
    } err]} {
        puts "Error writing to file \"$filename\": $err"
        close $fh
        return 1
    }

    close $fh
    return 0
}

proc readFromFile {filename} {
    if {[catch {set fh [open $filename r]} err]} {
        puts "Error reading from file \"$filename\": $err"
        return 1
    }

    set linesRead 0
    if {[catch {
        while {[gets $fh line] >= 0} {
            puts $line
            incr linesRead
        }
    } err]} {
        puts "Error reading from file \"$filename\": $err"
        close $fh
        return 1
    }

    if {$linesRead == 0} {
        puts "(File \"$filename\" is empty)"
    }

    close $fh
    return 0
}

set filename "output.txt"
if {[ writeToFile $filename] != 0} { exit 1 }
if {[readFromFile $filename] != 0} { exit 1 }

exit 0

