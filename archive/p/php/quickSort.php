<?php

function quicksort($array)
{
    // find array size
    $length = count($array);
    // base case test, if array of length 0 then just return array to caller
    if ($length <= 1) {
        return $array;
    } else {
        // select the last item to act as our pivot point
        $pivot = $array[$length - 1];
        // declare our two arrays to act as partitions
        $left = array();
        $right = array();
        // loop and compare each item in the array to the pivot value, place item in appropriate partition
        for ($i = 0; $i < $length - 1; $i++) {
            if ($array[$i] < $pivot) {
                $left[] = $array[$i];
            } else {
                $right[] = $array[$i];
            }
        }
        // use recursion to now sort the left and right lists
        return array_merge(quicksort($left), array($pivot), quicksort($right));
    }
}

function populateArray()
{
    $arr = array();
    for ($i = 0; $i < 10; $i++) {
        $num = rand(0, 1000);
        array_push($arr, $num);
    }
    return $arr;
}

var_dump(quicksort(populateArray()));

?>
