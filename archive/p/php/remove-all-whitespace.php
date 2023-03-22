<?php
function usage()
{
    exit("Usage: please provide a string");
}

function remove_all_whitespace($str)
{
    // Split on whitespace, join back together
    return implode("", preg_split("/\s+/", $str));
}

// Exit if too few arguments or 1st argument is empty
if (count($argv) < 2 || strlen($argv[1]) < 1)
{
    usage();
}

// Remove all whitespace and display string
$str = remove_all_whitespace($argv[1]);
echo "${str}\n";
