#!/usr/bin/perl
#Merge Sort using recursion
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

@merge_sorted_list = merge_sort (@arr);

# Print sorted numbers
        for ($i = 0;$i < $n;$i = $i + 1) {
            if ($i == 0) {
                print "$merge_sorted_list[$i]";
            } else {
                print ", $merge_sorted_list[$i]";
            }
        }
    }
}

sub merge_sort {
    my @temp_array = @_;
    return @temp_array if @temp_array < 2;
    my $m = int @temp_array / 2;
    my @a = merge_sort(@temp_array[0 .. $m - 1]);
    my @b = merge_sort(@temp_array[$m .. $#temp_array]);
    for (@temp_array) {
        $_ = !@a            ? shift @b
           : !@b            ? shift @a
           : $a[0] <= $b[0] ? shift @a
           :                  shift @b;
    }
    @temp_array;
}
