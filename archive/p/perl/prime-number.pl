# Requirement https://sample-programs.therenegadecoder.com/projects/prime-number/
# Issue  #1834
# Accept a number on command line and print if it is Prime or Composite
# Prime Numbers will have only 1 Divisor, itself..  Use that to determine Composite.
# Note: 0 and 1 are Composite numbers, 2 is a Prime Number
use warnings;

my ($prime) = @ARGV;

$num_args = $#ARGV + 1;

# Empty input
if ( $num_args < 1 ) {
    print("Usage: please input a non-negative integer");
    exit(0);
}

# Only Integer
if ( $prime =~ /^-?\d+$/ ) {

    # Negative Number
    if ( $prime < 0 ) {
        print("Usage: please input a non-negative integer");
        exit(0);
    }

    if ( $prime == 2 ) {
        print("Prime");
        exit(0);
    }

    # If 1 or the Number is Even
    elsif ( ( $prime == 1 ) || ( $prime == 0 ) || ( $prime % 2 == 0 ) ) {
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
