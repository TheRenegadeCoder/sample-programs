use 5.010;
use strict;
use warnings;
my $n;
print "Enter a positive integer:";
chomp($n=<STDIN>);
my ($i,$status)=(2,0);
while($i<=$n-1){
		if($n%$i==0){
			$status = 1;
			last;
		}
		$i++;
}
if($status == 0){
		print "$n is a prime number.. \n\n";
}
else{
		print "$n is Not a prime number.. \n\n";
}
