<?php
function usage()
{
    exit('Usage: please provide two lists in the format "1, 2, 3, 4, 5"');
}

function parse_int($str_value)
{
    // Remove leading and trailing spaces
    $str_value = trim($str_value);

    // Make sure all digits
    if (preg_match("/[+-]?^\d+$/", $str_value) === FALSE)
    {
        return FALSE;
    }

    // Make sure valid integer
    if (
        filter_var(
            $str_value,
            FILTER_VALIDATE_INT,
            array(
                'options' => array(
                    'decimal' => TRUE,
                    'min_range' => PHP_INT_MIN,
                    'max_range' => PHP_INT_MAX
                )
            )
        ) === FALSE
    )
    {
        return FALSE;
    }

    return intval($str_value);
}

function parse_int_array($str_values)
{
    $str_array = explode(",", $str_values);
    $values = array();
    foreach ($str_array as $str_value)
    {
        $value = parse_int($str_value);
        if ($value === FALSE)
        {
            return FALSE;
        }

        array_push($values, $value);
    }

    return $values;
}

// Longest Common Sequence
// Source: https://en.wikipedia.org/wiki/Longest_common_subsequence#Example_in_C#
//
// However, instead of storing lengths, and index to the subsequence is stored
function longest_common_subsequence($list1, $list2)
{
    // Initialize all subsequences to an empty sequence
    $m = count($list1);
    $n = count($list2);
    $c = array_fill(0, $m + 1, array_fill(0, $n + 1, 0));
    $subsequences = array(array());

    // Find the longest common subsequence using prior subsequences
    for ($i = 1; $i <= $m; $i++)
    {
        for ($j = 1; $j <= $n; $j++)
        {
            // If common element found, create new subsequence based on prior
            // subsequence with the common element appended
            if ($list1[$i - 1] == $list2[$j - 1])
            {
                $c[$i][$j] = count($subsequences);
                array_push(
                    $subsequences,
                    array_merge(
                        $subsequences[$c[$i - 1][$j - 1]],
                        array($list1[$i - 1])
                    )
                );
            }
            // Else, reuse the longer of the two prior subsequences
            else
            {
                $index1 = $c[$i][$j - 1];
                $index2 = $c[$i - 1][$j];
                $c[$i][$j] =
                    (count($subsequences[$index1]) > count($subsequences[$index2])) ?
                    $index1 : $index2;
            }
        }
    }

    return $subsequences[$c[$m][$n]];
}

// Exit if too few arguments
if (count($argv) < 3)
{
    usage();
}

// Parse 1st and 2nd argument. Exit if invalid
$list1 = parse_int_array($argv[1]);
$list2 = parse_int_array($argv[2]);
if ($list1 === FALSE || $list2 === FALSE)
{
    usage();
}

// Get longest common subsequence and display it
$result = longest_common_subsequence($list1, $list2);
printf("%s\n", implode(", ", $result));
