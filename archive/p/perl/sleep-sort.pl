#!/usr/bin/perl
#Sleep Sort
# Using Coro Module to 
## Avoid program sleeping when input is a huge number
## Avoid deadlocks between forked child-threads

use Coro;

$num_args = $#ARGV + 1;
# If no input was provided
if ($num_args == 0) {
    print "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"";
  } 
# If invalid input was provided
else {
    $input_string = $ARGV[0];
    my @arr = split(',',$input_string);
    $n = $#arr + 1;
    if ($n <= 1) {
	    print "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"";
    } 
#Input is fine    
    else {
# Convert input sting to Integers
        for ($i = 0;$i < $n;$i++) {
                $arr[$i] = int($arr[$i])
            } #end for

  @sleep_sorted_list = sleep_sort (@arr);
  } # End of Else input being fine
} # End of Else Non-Zero Input 


$ret = Coro::Channel->new;

sub sleep_sort{
  for my $n (@_){
    async {
      Coro::cede for 1..$n;
      $ret->put($n);
    }
  }
  return $ret
}

# Print sorted numbers
for ($i = 0;$i < $n;$i = $i + 1) {
    if ($i == 0) {
        print $ret->get;
    } else {
        print ", ", $ret->get;
    }
}
