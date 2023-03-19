
my ($str) = @ARGV;

if (defined $str) {
    print scalar reverse $str;
}
