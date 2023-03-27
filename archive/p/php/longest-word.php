<?php
function usage()
{
    exit("Usage: please provide a string");
}

function longest_word_length($str)
{
    // Split on whitespace, get string length of each word, take the maximum
    return max(array_map("strlen", preg_split("/\s+/", $str)));
}

// Exit if too few arguments or 1st command-line argument is empty
if (count($argv) < 2 || empty($argv[1]))
{
    usage();
}

// Get longest word length and display
$str = $argv[1];
$longest_len = longest_word_length($str);
echo "${longest_len}\n";
