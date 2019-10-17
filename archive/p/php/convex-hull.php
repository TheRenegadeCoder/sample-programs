<?php

/** Our error class. */
class ConvexHullException extends Exception {}

/** Point class. */
class Point {
    private $x, $y;

    /** Constructor.
     * @param x X coordinate
     * @param y Y coordinate
     */
    public function __construct($x, $y) {
        $this->x = $x;
        $this->y = $y;
    }

    /**
     * Determine if this point is left of another.
     * @param p Other point.
     * @return true if this point is left of $p, false otherwise.
     */
    public function isLeftOf($p) {
        return $this->x < $p->x;
    }

    /**
     * Determine if the orientation of this point and two other points is counterclockwise.
     * @param p2 Second point
     * @param p3 Third point.
     * @return true if counterclockwise, false otherwise.
     */
    public function isCounterclockwise($p2, $p3) {
        return ($p2->y - $this->y) * ($p3->x - $p2->x) -
               ($p2->x - $this->x) * ($p3->y - $p2->y) < 0;
    }

    /**
     * To String.
     * @return a string representation of the point.
     */
    public function __toString() {
        return "($this->x, $this->y)";
    }
}

/**
 * Compute the convex hull of the set of points.
 * @param points array of points to use
 * @return array of points that define the hull.
 */
function getConvexHull($points) {
    // find left-most point index
    $leftIndex = 0;
    $pointCount = count($points);
    for ($i = 0; $i < $pointCount; ++$i) {
        if ($points[$i]->isLeftOf($points[$leftIndex])) {
            $leftIndex = $i;
        }
    }

    // init the current point to the left-most
    $currentIndex = $leftIndex;
    $nextIndex = null;

    // build the hull
    $hullPoints = array();
    do {

        // add the current point to the hull
        $hullPoints[] = $points[$currentIndex];

        // move to the next and warp around if necessary.
        $nextIndex = $currentIndex + 1;
        if ($nextIndex >= $pointCount) {
            $nextIndex = 0;
        }

        // Find most counterclockwise point between current, candidate ($i), and next point.
        for ($i = 0; $i < $pointCount; ++$i) {
            if ($points[$currentIndex]->isCounterclockwise($points[$i], $points[$nextIndex])) {
                $nextIndex = $i;
            }
        }

        // next becomes current
        $currentIndex = $nextIndex;

    // stop if we're back at the beginning
    } while ($currentIndex != $leftIndex);

    return $hullPoints;
}

/**
 * Split a comma separated list into an array.
 * Subsequent commas and spaces are ignored.
 * @param list the comma separated string
 * @return array of values.
 */
function commaSeparatedToArray($list) {
    // \s*  zero or more white spaces
    // ,+   one or more commas
    // \s*  zero or more white spaces
    return preg_split("/\s*,+\s*/", $list);
}

/**
 * Convert a string to an integer.
 * @param str String to convert
 * @return integer
 * @throws ConvexHullException on invalid integers.
 */
function parseInt($str) {
    // ^      from start of string
    // [+-]?  optional + or - sign
    // \d+    one or more digits
    // $      to the end of the string
    if (preg_match('/^[+-]?\d+$/', $str) != 1) {
        throw new ConvexHullException("Coordinates must be integers.");
    }
    return intVal($str);
}

/**
 * Take two lists of x and y points and return an array of Point objects.
 * @param xs the X coordinates for the points.
 * @param ys the Y coordinates for the points.
 * @return array of Point objects.
 * @throws ConvexHullException on list mismatch or invalid integers.
 */
function parsePoints($xs, $ys) {
    $xs = commaSeparatedToArray($xs);
    $ys = commaSeparatedToArray($ys);

    if (count($xs) != count($ys)) {
        throw new ConvexHullException("Coordinate list mismatch.");
    }

    $points = array();
    for ($i = 0; $i < count($xs); ++$i) {
        $points[] = new Point(parseInt($xs[$i]), parseInt($ys[$i]));
    }

    return $points;
}

/**
 * Display the usage, optional error message and exit with the optional code.
 * @param exitCode exit code
 * @param errorMessage error message
 */
function usage($exitCode=0, $errorMessage=FALSE) {
    echo "Usage: input points in the form of: \"x1, x2, x3, ...\" \"y1, y2, y3, ...\"\n";
    if ($errorMessage) {
        echo "\nError: ", $errorMessage, "\n";
    }
    exit($exitCode);
}

// Main
try {

    // arg check
    if ($argc < 3) {
        usage();
    }

    // Parse points from command line, and get hull points
    $points = parsePoints($argv[1], $argv[2]);
    $hullPoints = getConvexHull($points);

    // Print the results
    foreach ($hullPoints as $point) {
        echo $point, "\n";
    }

} catch (ConvexHullException $e) {
    usage(1, $e->getMessage());
}

?>
