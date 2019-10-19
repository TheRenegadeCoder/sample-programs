<?php

$numbers = array_map('intval', explode(',', $argv[1]));
$array_size = count($numbers);
if ($array_size <= 1)
{
    exit('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
}


function selection_sort($data)
{
for($i=0; $i<count($data)-1; $i++) {
	$min = $i;
	for($j=$i+1; $j<count($data); $j++) {
		if ($data[$j]<$data[$min]) {
			$min = $j;
		}
	}
    $data = swap_positions($data, $i, $min);
}
return $data;
}

function swap_positions($data1, $left, $right) {
	$backup = $data1[$right];
	$data1[$right] = $data1[$left];
	$data1[$left] = $backup;
	return $data1;
}

echo implode(', ',selection_sort($numbers));
?>
