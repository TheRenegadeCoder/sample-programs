
my ($str) = @ARGV;

if (not defined $str) {
    die "Please supply a string as the first parameter\n";
}

print scalar reverse $str;
