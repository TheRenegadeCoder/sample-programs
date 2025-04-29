function usage() {
    print "Usage: please provide at least 3 x and y coordinates as separate lists (e.g. \"100, 440, 210\")"
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

function str_to_array(s, arr,  str_arr, idx, result) {
    split(s, str_arr, ",")
    for (idx in str_arr) {
        result = str_to_number(str_arr[idx])
        if (result == "ERROR") {
            delete arr
            arr[1] = "ERROR"
            break
        } else {
            arr[idx] = result
        }
    }
}

function form_points(x_points, y_points, points,  idx) {
    for (idx in x_points) {
        points[idx]["x"] = x_points[idx]
        points[idx]["y"] = y_points[idx]
    }
}

# Find Convex Hull using Jarvis' algorithm
# Source: https://www.geeksforgeeks.org/convex-hull-using-jarvis-algorithm-or-wrapping/
function convex_hull(points, num_points, hull_points,  idx, i, j, l, p, q) {
    # The first point is the leftmost point with the highest y-coord in the
    # event of a tie
    l = find_leftmost_point(points)

    # Repeat until wrapped around to first hull point
    p = l
    i = 0
    do {
        # Store convex hull point
        i++
        hull_points[i]["x"] = points[p]["x"]
        hull_points[i]["y"] = points[p]["y"]

        q = 1 + (p % num_points)
        for (j = 1; j <= num_points; j++) {
            # If point j is counter-clockwise, then update end point (q)
            if (orientation(points[p], points[j], points[q]) < 0) {
                q = j
            }
        }

        p = q
    } while (p != l)
}

function find_leftmost_point(points,  idx, min_index, x_min, y_max, x, y) {
    x_min = 1e999
    y_max = -1e999
    min_index = 0
    for (idx in points) {
        x = points[idx]["x"]
        y = points[idx]["y"]
        if ((x < x_min) || (x == x_min && y > y_max)) {
            x_min = x
            y_max = y
            min_index = idx
        }
    }

    return min_index
}

# Get orientation of three points
#
# 0 = points are in a line
# > 0 = points are clockwise
# < 0 = points are counter-clockwise
function orientation(p, q, r) {
    return (q["y"] - p["y"]) * (r["x"] - q["x"]) - \
        (q["x"] - p["x"]) * (r["y"] - q["y"])
}

function show_points(points,  idx) {
    for (idx in points) {
        printf("(%d, %d)\n", points[idx]["x"], points[idx]["y"])
    }
}

BEGIN {
    if (ARGC < 2) {
        usage()
    }

    str_to_array(ARGV[1], x_points)
    x_len = length(x_points)
    str_to_array(ARGV[2], y_points)
    y_len = length(y_points)
    if (x_len < 3 || y_len < 3 || x_len != y_len) {
        usage()
    }

    form_points(x_points, y_points, points)
    convex_hull(points, x_len, hull_points)
    show_points(hull_points)
}
