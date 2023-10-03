#!/usr/bin/perl
#Selection Sort
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

@selection_sorted_list = selection_sort (@arr);

# Print sorted numbers
        for ($i = 0;$i < $n;$i = $i + 1) {
            if ($i == 0) {
                print "$selection_sorted_list[$i]";
            } else {
                print ", $selection_sorted_list[$i]";
            }
        }
    }
}

sub selection_sort
  {my @a = @_;
   foreach my $i (0 .. $#a - 1)
      {my $min = $i + 1;
       $a[$_] < $a[$min] and $min = $_ foreach $min .. $#a;
       $a[$i] > $a[$min] and @a[$i, $min] = @a[$min, $i];}
   return @a;}
