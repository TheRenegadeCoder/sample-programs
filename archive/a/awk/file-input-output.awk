function write_file(filename) {
    print "Hello from awk" >filename
    print "Line 1" >>filename
    print "Line 2" >>filename
    print "Goodbye from awk" >>filename
    close(filename)
}

# Reference: https://www.gnu.org/software/gawk/manual/html_node/Getline_002fVariable_002fFile.html
function read_file(filename) {
    while (getline line < filename) {
        print line
    }

    close(filename)
}

BEGIN {
    filename = "output.txt"
    write_file(filename)
    read_file(filename)
}
