<?php
function usage()
{
    exit(
        'Usage: please provide at least 3 x and y coordinates as separate lists ' .
        '(e.g. "100, 440, 210")'
    );
}

function parse_int($str_value)
{
    // Remove leading and trailing spaces
    $str_value = trim($str_value);

    // Make sure all digits
    if (preg_match("/^[+-]?\d+$/", $str_value) === FALSE)
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

// Combine values into a set of points
function form_points($x_values, $y_values)
{
    return array_map(
        function ($x, $y) { return new Point($x, $y); },
        $x_values, $y_values
    );
}

// Find Convex Hull using Jarvis' algorithm
// Source: https://www.geeksforgeeks.org/convex-hull-using-jarvis-algorithm-or-wrapping/
function convex_hull($points)
{
    $n = count($points);

    // Initialize hull points
    $hull_points = array();

    // The first point is the leftmost point with the highest y-coord in the
    // event of a tie
    $l = find_leftmost_point($points);

    // Repeat until wrapped around to first hull point
    $p = $l;
    do
    {
        // Store convex hull point
        array_push($hull_points, $points[$p]);

        $q = ($p + 1) % $n;
        for ($j = 0; $j < $n; $j++)
        {
            // If point j is more counter-clockwise, then update end point (q)
            if (orientation($points[$p], $points[$j], $points[$q]) < 0)
            {
                $q = $j;
            }
        }

        $p = $q;
    }
    while ($p != $l);

    return $hull_points;
}

function find_leftmost_point($points)
{
    $n = count($points);
    $leftmost_point = new Point(PHP_INT_MAX, PHP_INT_MIN);
    $leftmost_index = 0;
    foreach ($points as $k => $point)
    {
        // In the event of a tie, pick the point with the greater y-coord
        if (
            $point->x < $leftmost_point->x or 
            ($point->x == $leftmost_point->x and $point->y > $leftmost_point->y)
        )
        {
            $leftmost_point = $point;
            $leftmost_index = $k;
        }
    }

    return $leftmost_index;
}

// Get orientation of three points
//
// 0 = points are in a line
// > 0 = points are clockwise
// < 0 = points are counter-clockwise
function orientation($p, $q, $r)
{
    return (
        ($q->y - $p->y) * ($r->x - $q->x) -
        ($q->x - $p->x) * ($r->y - $q->y)
    );
}


function show_points($points)
{
    foreach ($points as $point)
    {
        printf("%s\n", $point->to_string());
    }
}

class Point
{
    public $x;
    public $y;

    public function __construct($x, $y)
    {
        $this->x = $x;
        $this->y = $y;
    }

    public function to_string()
    {
        return "({$this->x}, {$this->y})";
    }
}

// Exit if too few arguments
if (count($argv) < 3 || empty($argv[1]) || empty($argv[2]))
{
    usage();
}

// Exit if 1st or 2nd argument invalid
$x_values = parse_int_array($argv[1]);
$y_values = parse_int_array($argv[2]);
if ($x_values === FALSE || $y_values === FALSE)
{
    usage();
}

// Exit if not same number of points or less than 3 points
$num_x = count($x_values);
$num_y = count($y_values);
if ($num_x != $num_y || $num_x < 3)
{
    usage();
}

// Combine values into set of points
$points = form_points($x_values, $y_values);

// Get convex hull of points and show points
$hull_points = convex_hull($points);
show_points($hull_points);
