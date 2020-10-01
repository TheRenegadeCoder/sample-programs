#prime number checker
#issue 1507 opened on 10 Oct 2019 by wileymab

use warnings;
use strict;

sub testprime
	{
		my $m = shift @_;
		my $i = 2;
		while ($i < $m)
		{
			return 0 unless ($m % $i++);
		}
	return 1;
	}

print “Enter a number to find the prime \n”;
chomp (my $n = <STDIN>);

my $FindPrime = testprime $n;

if ( $FindPrime == 1)
	{
		print “Yes, the given number is Prime \n”;
	}
else
	{
		print “No, It is NOT a prime Number \n”;
	}