<?php

if (count($argv) == 2 && strlen($argv[1])) {
    $inputString = $argv[1];
    $capitalized = ucfirst($inputString);
    echo $capitalized;
} else {
    echo "Usage: please provide a string";
}
