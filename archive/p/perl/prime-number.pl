# Requirement https://sample-programs.therenegadecoder.com/projects/prime-number/
# Issue  #1834
# Accept a number on command line and print if it is Prime or Composite
# Prime Numbers will have only 1 Divisor, itself..  Use that to determine Composite.

use warnings;

my ($prime) = @ARGV;

# if (not defined $prime) {
#   die "please input a non-negative integer";
# }

# print "Arguments are ", $ARGV[0], "KAJJI", $ARGV[1], "KAJJI";

$num_args = $#ARGV + 1;

# Empty input
if ( $num_args < 1 ) {
    print "Usage: please input a non-negative integer";
    exit(0);
}

# Negative Number
if ( $prime < 0 ) {
    print("Usage: please input a non-negative integer");
    exit(0);
}

# Only Integer
if ( $prime =~ /^-?\d+$/ ) {

    # If 1 or te Number is Even
    if ( ( $prime == 1 ) || ( $prime % 2 == 0 ) ) {
        print("Composite");
        exit(0);
    }
    else {
        #   Check how many divisors for the given number
        $i               = 0;
        $num_of_divisors = 0;

        #   Number is guaranteed to be Even
        for ( $i = $prime ; $i > 1 ; $i = $i - 2 ) {
            if ( $prime % $i == 0 ) {
                $num_of_divisors += 1;
            }
        }

        # If more than 2 divisors
        if ( $num_of_divisors > 2 ) {
            print("Composite");
        }
        else {
            print("Prime");
        }
    }

}
        # If not Integer
else {
    print "Usage: please input a non-negative integer";
    exit(0);
}
