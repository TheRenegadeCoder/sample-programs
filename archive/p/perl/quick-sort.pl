#!/usr/bin/perl
#Quick Sort using recursion on last element as pivot key
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

@quicksortedlist = quicksort(@arr);
# Print sorted numbers
        for ($i = 0;$i < $n;$i = $i + 1) {
            if ($i == 0) {
                print "$quicksortedlist[$i]";
            } else {
                print ", $quicksortedlist[$i]";
            }
        }
    }
}


sub quicksort 
{
  my @list = @_;
  if($#list < 1)
  {
    return @list;
  }
  my $pivot_key = pop(@list);
  my @elements_smaller_than_pivot_key; 
  my @elements_greather_than_pivot_key;
  foreach my $element (@list) 
  {
    if ($element < $pivot_key)
    {
      push(@elements_smaller_than_pivot_key, $element);
    } 
    else 
    {
      push(@elements_greather_than_pivot_key, $element);
    }
  }
  return quicksort(@elements_smaller_than_pivot_key), $pivot_key, quicksort(@elements_greather_than_pivot_key);
}
