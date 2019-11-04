# Requirement https://sample-programs.therenegadecoder.com/projects/prime-number/
# Issue  #1834
# Accept a number on command line and print if it is Prime or Composite
# Prime Numbers will have only 1 Divisor, itself..  Use that to determine Composite.

use warnings;

my ($prime) = @ARGV;

$num_args = $#ARGV + 1;

if ($num_args <1 ) {
    print "PHAT   Usage: please input a non-negative intege";
    exit(0);
}

if ( $prime < 0 ) {
    print("Usage: please input a non-negative integer");
    exit(0);
}
else {
    if ( $prime % 2 == 0 ) {
        print("Composite");
        exit(0);
    }
    else {

        $i               = 0;
        $num_of_divisors = 0;
        for ( $i = $prime ; $i > 1 ; $i = $i - 2 ) {
            if ( $prime % $i == 0 ) {
                $num_of_divisors += 1;
            }
        }
        if ( $num_of_divisors > 2 ) {
            print("Composite");
        }
        else {
            print("Prime");
        }
    }
}
