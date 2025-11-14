divert(-1)
define(`show_usage',
`Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210")
m4exit(`1')')

dnl Reference: https://www.gnu.org/software/m4/manual/m4.html#index-array
dnl array_get(var_name, idx)
define(`array_get', `defn(format(``%s[%s]'', `$1', `$2'))')

dnl array_set(var_name, idx, value)
define(`array_set', `define(format(``%s[%s]'', `$1', `$2'), `$3')')

dnl 2D versions of "array_get" and "array_set"
dnl array2_get(varname, idx1, idx2)
define(`array2_get', `defn(format(``%s[%s][%s]'', `$1', `$2', `$3'))')

dnl array2_set(varname, idx1, idx2, value)
define(`array2_set', `define(format(``%s[%s][%s]'', `$1', `$2', `$3'), `$4')')

dnl is_valid(n)
define(`is_valid', `eval(regexp(`$1', `^\s*-?[0-9]+\s*$') >= 0)')

dnl parse_int_list(varname, args):
dnl   varname[length] = 0
dnl   foreach arg in args:
dnl     if not is_valid(arg):
dnl       Return 0
dnl     varname[varname[length]] = arg
dnl     varname[length] = varname[length] + 1
dnl   Return 1
define(`parse_int_list',
`array_set(`$1', `length', 0)dnl
_parse_int_list(`$1', $2)'dnl
)
define(`_parse_int_list',
`ifelse(is_valid(`$2'), 0, `0',
`array_set(`$1', array_get(`$1', `length'), `$2')dnl
array_set(`$1', `length', incr(array_get(`$1', `length')))dnl
ifelse(eval($# > 2), 1, `_parse_int_list(`$1', shift(shift($@)))', `1')'dnl
)'dnl
)

dnl form_points(x_varname, y_varname, points_varname):
dnl   points_varname["length"] = x_varname["length"]
dnl   for i = 0 to points_varname["length"] - 1:
dnl     points_varname[i]["x"] = x_varname[i]
dnl     points_varname[i]["y"] = y_varname[i]
define(`form_points',
`array_set(`$3', `length', array_get(`$1', `length'))dnl
_form_points(`$1', `$2', `$3', 0)dnl
'dnl
)

dnl x_varname=$1, y_varname=$2, points_varname=$3, i=$4
define(`_form_points',
`ifelse(eval($4 < array_get(`$1', `length')), 1,
`array2_set(`$3', `$4', `x', array_get(`$1', `$4'))dnl
array2_set(`$3', `$4', `y', array_get(`$2', `$4'))dnl
_form_points(`$1', `$2', `$3', incr($4))dnl
'dnl
)'dnl
)

dnl show_points(points_varname):
dnl   for i = 0 to points_varname["length"] - 1
dnl     Output "(" + points_varname[i]["x"] + ", " + points_varname[i]["y"] + ")"
define(`show_points', `_show_points(`$1', 0)')

dnl points_varname=$1, i=$2
define(`_show_points',
`ifelse(eval($2 < array_get(`$1', `length')), 1,
`(array2_get(`$1', `$2', `x'), array2_get(`$1', `$2', `y'))
_show_points(`$1', incr($2))dnl
'dnl
)'dnl
)

dnl Find Convex Hull using Jarvis' algorithm
dnl Source: https://www.geeksforgeeks.org/convex-hull-using-jarvis-algorithm-or-wrapping/
dnl convex_hull(points_varname, hull_points_varname):
dnl   // The first point is the leftmost point with the highest y-coord in the
dnl   // event of a tie
dnl   l = find_leftmost_point(points_varname)
dnl
dnl   // Repeat until wrapped around to first hull point
dnl   p = l
dnl   i = 0
dnl   do
dnl     // Store convex hull point
dnl     hull_points_varname[i]["x"] = points_varname[p]["x"]
dnl     hull_points_varname[i]["y"] = points_varname[p]["y"]
dnl     i = i + 1
dnl     hull_points_varname["length"] = i
dnl
dnl     q = (p + 1) % points_varname["length"]
dnl     for j  = 0 to points_varname["length"] - 1:
dnl       // If point j is counter-clockwise, then update end point (q)
dnl       if orientation(points_varname, p, j, q) < 0:
dnl         q = j
dnl
dnl     p = q
dnl   while p != l
define(`convex_hull',
`pushdef(`l', `find_leftmost_point(`$1')')dnl
pushdef(`p', l)dnl
pushdef(`q', `')dnl
_convex_hull_outer(`$1', `$2', 0)dnl
popdef(`q')dnl
popdef(`p')dnl
'dnl
)

dnl points_varname=$1, hull_points_varname=$2, i=$3
define(`_convex_hull_outer',
`array2_set(`$2', `$3', `x', array2_get(`$1', p, `x'))dnl
array2_set(`$2', `$3', `y', array2_get(`$1', p, `y'))dnl
array_set(`$2', `length', incr($3))dnl
define(`q', eval((p + 1) % array_get(`$1', `length')))dnl
_convex_hull_inner(`$1', 0)dnl
define(`p', q)dnl
ifelse(eval(p != l), 1, `_convex_hull_outer(`$1', `$2', incr($3))')dnl
'dnl
)

dnl points_varname=$1, j=$2
define(`_convex_hull_inner',
`ifelse(eval($2 < array_get(`$1', `length')), 1,
`ifelse(eval(orientation(`$1', p, `$2', q) < 0), 1, `define(`q', `$2')')dnl
_convex_hull_inner(`$1', incr($2))dnl
'dnl
)'dnl
)

dnl Get orientation of three points
dnl
dnl 0 = points are in a line
dnl > 0 = points are clockwise
dnl < 0 = points are counter-clockwise
dnl orientation(points_varname, p, q, r):
dnl   return (points_varname[q]["y"] - points_varname[p]["y"]) *
dnl     (points_varname[r]["x"] - points_varname[q]["x"]) -
dnl     (points_varname[q]["x"] - points_varname[p]["x"]) *
dnl     (points_varname[r]["y"] - points_varname[q]["y"])
define(`orientation',
`eval(
(array2_get(`$1', `$3', `y') - array2_get(`$1', `$2', `y')) *
(array2_get(`$1', `$4', `x') - array2_get(`$1', `$3', `x')) -
(array2_get(`$1', `$3', `x') - array2_get(`$1', `$2', `x')) *
(array2_get(`$1', `$4', `y') - array2_get(`$1', `$3', `y'))
)'dnl
)

dnl M4 does not have infinity so choose smallest integer value as minus infinity
dnl and the largest integer value for infinity
define(`MINUS_INF', -2147483648)
define(`INF', 2147483647)

dnl find_leftmost_point(points_varname):
dnl   x_min = INF
dnl   y_max = MINUS_INF
dnl   min_idx = -1
dnl   for i = 0 to points_varname["length"] - 1:
dnl     if points_varname[i]["x"] < x_min or
dnl       (points_varname[i]["x"] == x_min and points_varname[i]["y"] > y_max):
dnl       x_min = points_varname[i]["x"]
dnl       y_max = points_varname[i]["y"]
dnl       min_idx = i
dnl   return min_idx
define(`find_leftmost_point', `_find_leftmost_point(`$1', INF, MINUS_INF, -1, 0)')

dnl points_varname=$1, x_min=$2, y_max=$3, min_idx=$4, i=$5
define(`_find_leftmost_point',
`ifelse(eval($5 >= array_get(`$1', `length')), 1, `$4',
`ifelse(eval(array2_get(`$1', `$5', `x') < $2 ||
(array2_get(`$1', `$5', `x') == $2 && array2_get(`$1', `$5', `y') > $3)), 1,
`_find_leftmost_point(`$1', array2_get(`$1', `$5', `x'), array2_get(`$1', `$5', `y'), $5, incr($5))',
`_find_leftmost_point(`$1', `$2', `$3', `$4', incr($5))'dnl
)'dnl
)'dnl
)

divert(0)dnl
ifelse(eval(ARGC < 2 ||
    !parse_int_list(`x_values', ARGV1) ||
    !parse_int_list(`y_values', ARGV2)
), 1, `show_usage()')dnl
ifelse(eval(array_get(`x_values', `length') < 3 ||
    array_get(`y_values', `length') < 3 ||
    array_get(`x_values', `length') != array_get(`y_values', `length')
), 1, `show_usage()')dnl
form_points(`x_values', `y_values', `points')dnl
convex_hull(`points', `hull_points')dnl
show_points(`hull_points')dnl
