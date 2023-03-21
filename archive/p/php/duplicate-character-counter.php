<?php
function usage()
{
    exit("Usage: please provide a string");
}

function duplicate_character_counter($str)
{
    // Count number of occurances of each character
    $counts = array();
    $len = strlen($str);
    for ($index = 0; $index < $len; $index++)
    {
        $ch = $str[$index];
        if (!array_key_exists($ch, $counts))
        {
            $counts[$ch] = 0;
        }

        $counts[$ch] += 1;
    }

    return $counts;
}

function show_duplicate_character_counts($counts)
{
    // Show characters that have duplicates and keep track if
    // duplicates found
    $has_dupes = FALSE;
    foreach ($counts as $char => $count)
    {
        if ($count > 1)
        {
            echo "${char}: ${count}\n";
            $has_dupes = TRUE;
        }
    }

    // Indicate if no duplicates found
    if (!$has_dupes)
    {
        echo "No duplicate characters\n";
    }
}

// Get 1st argument. Exit if too few arguments or empty argument
if (count($argv) < 2 || empty($argv[1]))
{
    usage();
}

// Count duplicate characters
$str = $argv[1];
$counts = duplicate_character_counter($str);

// Show all duplicate character counts in order in which they occurred in string (if any)
show_duplicate_character_counts($counts);
