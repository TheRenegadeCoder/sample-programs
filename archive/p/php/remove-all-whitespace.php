<?php
function usage()
{
    exit("Usage: please provide a string");
}

function remove_all_whitespace($str)
{
    return preg_replace("/\s+/", "", $str);
}

// Exit if too few arguments or 1st argument is empty
if (count($argv) < 2 || empty($argv[1]))
{
    usage();
}

// Remove all whitespace and display string
$str = remove_all_whitespace($argv[1]);
echo "${str}\n";
