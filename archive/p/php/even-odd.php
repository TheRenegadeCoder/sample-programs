<?php

if ($argc < 2 || !is_numeric($argv[1])) {
    die("Usage: please input a number\n");
}

$input = abs($argv[1]);

if($input % 2 == 0 ){
    echo "Even\n";
} elseif($input % 2 == 1){
    echo "Odd\n";
} 