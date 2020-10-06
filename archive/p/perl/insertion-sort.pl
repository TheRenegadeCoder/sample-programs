#!/usr/bin/perl
$num_args = $#ARGV + 1;
if ($num_args == 0) {
    print "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"";
} else {
    $input_string = $ARGV[0];
    my @arr = split(',',$input_string);
    $n = $#arr + 1;
    if ($n <= 1) {
	print "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"";
    } else {
	for ($i = 0;$i < $n;$i++) {
	    $arr[$i] = int($arr[$i])
	}
        for ($i = 1;$i < $n;$i = $i + 1) {
            $p = $arr[$i];
	    $j = $i - 1;
	    while($j >= 0 && $arr[$j] > $p) {
		$arr[$j + 1] = $arr[$j];
		$j = $j - 1;
	    }
	    $arr[$j + 1] = $p;
        }
        for ($i = 0;$i < $n;$i = $i + 1) {
            if ($i == 0) {
                print "$arr[$i]";
            } else {
                print ", $arr[$i]";
            }
        }
    }
}
