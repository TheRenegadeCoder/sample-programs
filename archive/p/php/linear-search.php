<?php
function usage()
{
    exit('Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")');
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

// Exit if too few arguments
if (count($argv) < 3)
{
    usage();
}

// Parse 1st argument. Exit if invalid or too few values
$values = parse_int_array($argv[1]);
if ($values === FALSE || count($values) < 1)
{
    usage();
}

// Parse 2nd argument. Exit if invalid
$target = parse_int($argv[2]);
if ($target === FALSE)
{
    usage();
}

// Use built-in linear search and show result
$index = array_search($target, $values);
printf("%s\n", ($index !== FALSE) ? "true" : "false");
