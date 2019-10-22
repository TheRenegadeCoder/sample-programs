<?php
 
    $numbers = array_map('intval', explode(',', $argv[1]));
    $array_size = count($numbers);
    
    if ($array_size <= 1)
    {
        exit('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
    }
 
    function quicksort($array)
    {
        if (count($array) == 0)
            return array();
 
        $pivot_element = $array[0];
        $left_element = $right_element = array();
 
        for ($i = 1; $i < count($array); $i++) {
            if ($array[$i] <$pivot_element)
                $left_element[] = $array[$i];
            else
                $right_element[] = $array[$i];
        }
 
        return array_merge(quicksort($left_element), array($pivot_element), quicksort($right_element));
    }
 
    $sorted_numbers = quicksort($numbers);
 
    echo implode(', ', $sorted_numbers);
?>
