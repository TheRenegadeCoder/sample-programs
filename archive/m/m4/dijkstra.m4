divert(-1)
define(`show_usage',
`Usage: please provide three inputs: a serialized matrix, a source node and a destination node
m4exit(`1')')

dnl Reference: https://www.gnu.org/software/m4/manual/m4.html#index-array
dnl array_get(varname, idx)
define(`array_get', `defn(format(``%s[%s]'', `$1', `$2'))')

dnl array_set(varname, idx, value)
define(`array_set', `define(format(``%s[%s]'', `$1', `$2'), `$3')')

dnl 2D versions of "array_get" and "array_set"
dnl array2_get(varname, idx1, idx2)
define(`array2_get', `defn(format(``%s[%s][%s]'', `$1', `$2', `$3'))')

dnl array2_set(varname, idx1, idx2, value)
define(`array2_set', `define(format(``%s[%s][%s]'', `$1', `$2', `$3'), `$4')')

dnl 3D versions of "array_get" and "array_set"
dnl array3_get(varname, idx1, idx2, idx3)
define(`array3_get', `defn(format(``%s[%s][%s][%s]'', `$1', `$2', `$3', `$4'))')

dnl array3_set(varname, idx1, idx2, idx3, value)
define(`array3_set', `define(format(``%s[%s][%s][%s]'', `$1', `$2', `$3', `$4'), `$5')')

dnl is_valid(n)
define(`is_valid', `eval(regexp(`$1', `^\s*-?[0-9]+\s*$') >= 0)')

dnl parse_int_list(varname, args):
dnl   varname["length"] = 0
dnl   foreach arg in args:
dnl     if not is_valid(arg):
dnl       Return 0
dnl     varname[varname["length"]] = arg
dnl     varname["length"] = varname["length"] + 1
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

dnl Reference: https://en.wikipedia.org/wiki/Integer_square_root#Algorithm_using_Newton's_method
dnl isqrt(n):
dnl   if n < 2:
dnl     return n
dnl   prev2 = -1
dnl   prev1 = 1
dnl   while 1:
dnl     x1 = (prev1 + n // prev1) // 2
dnl
dnl     // Case 1: converged (steady value)
dnl     if x1 == prev1:
dnl       return x1
dnl
dnl     // Case 2: oscillation (2-cycle)
dnl     if x1 == prev2 and x1 != prev1:
dnl       return min(prev1, x1)
dnl
dnl     // Set up next values
dnl     prev2, prev1 = prev1, x1
define(`isqrt', `ifelse(eval($1 < 2), 1, $1,
`pushdef(`x1', 0)dnl
_isqrt($1, -1, 1)dnl
popdef(`x1')dnl
'dnl
)'dnl
)

dnl $1=n, $2=prev2, $3=prev1
define(`_isqrt',
`define(`x1', eval(($3 + $1 / $3) >> 1))dnl
ifelse(eval(x1 == $3), 1, x1,
`ifelse(eval(x1 == $2 && x1 != $3), 1, `min(`$3', x1)', `_isqrt(`$1', `$3', x1)')'dnl
)'dnl
)

dnl min(a, b)
define(`min', `ifelse(eval($1 < $2), $1, $2)')

dnl validate_inputs(weights_varname, num_vertices, src, dest):
dnl   // Verify number of weights is a square, source and destination are valid
dnl   if (weights_varname["length"] != num_vertices * num_vertices or
dnl     src < 0 or src >= num_vertices or dest < 0 or dest >= num_vertices):
dnl     return 0
dnl
dnl   // Verify weights greater than equal to zero and any non-zero weights
dnl   any_non_zero = 0
dnl   for i = 0 to weights_varname["length"] - 1
dnl     if weights_varname[i] < 0:
dnl       return 0
dnl
dnl     if weights_varname[i] > 0:
dnl       any_non_zero = 1
dnl
dnl   return any_non_zero
define(`validate_inputs',
`ifelse(eval(array_get(`$1', `length') != $2 * $2 ||
$3 < 0 || $3 >= $2 || $4 < 0 || $4 >= $2), 1, 0, `validate_weights(`$1', 0, 0)'dnl
)'dnl
)

dnl weights_varname=$1, i=$2, any_non_zero=$3
define(`validate_weights',
`ifelse(eval($2 >= array_get(`$1', `length')), 1, `$3',
`ifelse(eval(array_get(`$1', `$2') < 0), 1, 0,
eval(array_get(`$1', `$2') > 0), 1,
`validate_weights(`$1', incr($2), 1)', `validate_weights(`$1', incr($2), `$3')'dnl
)'dnl
)'dnl
)

dnl create_graph(weights_varname, num_vertices, graph_varname):
dnl   // Create nodes
dnl   graph_varname["length"] = num_vertices
dnl   for i = 0 to num_vertices - 1:
dnl     graph_varname[i]["length"] = 0
dnl
dnl   // Connect children to nodes
dnl   idx = 0
dnl   for i = 0 to num_vertices - 1:
dnl     for j = 0 to num_vertices - 1:
dnl       if weight_mtx_varname[idx] > 0:
dnl         graph_varname[i]["edge"][graph_varname[i]["length"]] = j
dnl         graph_varname[i]["weight"][graph_varname[i]["length"]] = weights_varname[idx]
dnl         graph_varname[i]["length"] = graph_varname[i]["length"] + 1
dnl
dnl       idx = idx + 1
define(`create_graph',
`array_set(`$3', `length', `$2')dnl
_create_nodes(`$3', `$2', 0)dnl
_connect_children(`$1', `$2', `$3', 0, 0)dnl
'dnl
)

dnl graph_varname=$1, num_vertices=$2, i=$3
define(`_create_nodes',
`ifelse(eval($3 < $2), 1,
`array2_set(`$1', `$3', `length', 0)dnl
_create_nodes(`$1', `$2', incr($3))'dnl
)'dnl
)

dnl weights_varname=$1, num_vertices=$2, graph_varname=$3, i=$4, idx=$5
define(`_connect_children',
`ifelse(eval($4 < $2), 1,
`_connect_children_inner(`$1', `$2', `$3', `$4', `$5', 0)dnl
_connect_children(`$1', `$2', `$3', incr($4), eval($5 + $2))'dnl
)'dnl
)

dnl weights_varname=$1, num_vertices=$2, graph_varname=$3, i=$4, idx=$5, j=$6
define(`_connect_children_inner',
`ifelse(eval($6 < $2), 1,
`ifelse(eval(array_get(`$1', `$5') > 0), 1,
`array3_set(`$3', `$4', `edge', array2_get(`$3', `$4', `length'), `$6')dnl
array3_set(`$3', `$4', `weight', array2_get(`$3', `$4', `length'), array_get(`$1', $5))dnl
array2_set(`$3', `$4', `length', incr(array2_get(`$3', `$4', `length')))'dnl
)dnl
_connect_children_inner(`$1', `$2', `$3', `$4', incr($5), incr($6))'dnl
)'dnl
)

dnl M4 does not have infinity so choose largest integer value as infinity
define(`INF', 2147483647)

dnl Source: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
dnl dijkstra(graph_varname, src, dists_varname):
dnl   // Note: unvisited (q) is a string that looks like this: "|<node1>||<node2>|..."
dnl   // Since M4 does not have anything like a set, this is the easiest way to
dnl   // represent it, and the "index" function can be used to see if a node is
dnl   // unvisited (non-negative if unvisited)
dnl
dnl   // Initialize distances to infinite and initialize unvisited nodes
dnl   q = ""
dnl   dists_varname["length"] = graph_varname["length"]
dnl   for i = 0 to dists_varname["length"] - 1:
dnl     dists_varname[i] = INF
dnl     q = q + "|" + i + "|"
dnl
dnl   // Set first vertex distance to 0
dnl   dists_varname[src] = 0
dnl
dnl   // While any unvisited nodes
dnl   while q != "":
dnl     // Pick a vertex u in q with minimum distance
dnl     u = find_min_distance(dists_varname)
dnl
dnl     // Remove vertex u from q
dnl     q = replace(q, "|" + u + "|", "")
dnl
dnl     // For each neighbor v of vertex u still in q
dnl     for i = 0 to graph[u]["length"] - 1:
dnl       v = graph_varname[u]["edge"][i]
dnl       if ("|" + v + "|) in q:
dnl         // Get trial distance. If it is smaller than distance v, update distance to v
dnl         alt = add(dists_varname[u], graph_varname[u]["weight"][i])
dnl         if alt < dists_varname[v]:
dnl           dists_varname[v] = alt
define(`dijkstra', 
`pushdef(`q', `')dnl
pushdef(`u', `')dnl
pushdef(`v', `')dnl
pushdef(`alt', `')dnl
array_set(`$3', `length', array_get(`$1', `length'))dnl
_init_dijkstra_result(`$3', 0)dnl
array_set(`$3', `$2', 0)dnl
_dijkstra_outer(`$1', `$3')dnl
popdef(`alt')dnl
popdef(`v')dnl
popdef(`u')dnl
popdef(`q')dnl
')

dnl dists_varname=$1, i=$2
define(`_init_dijkstra_result',
`ifelse(eval($2 < array_get(`$1', `length')), 1,
`array_set(`$1', `$2', INF)dnl
define(`q', q`|$2|')dnl
_init_dijkstra_result(`$1', incr($2))'dnl
)'dnl
)

dnl graph_varname=$1, dists_varname=$2
define(`_dijkstra_outer',
`ifelse(q, `',,
`define(`u', find_min_distance(`$2'))dnl
define(`q', patsubst(q, `|'u`|'))dnl
_dijkstra_inner(`$1', `$2', 0)dnl
_dijkstra_outer(`$1', `$2')dnl
'dnl
)'dnl
)

dnl graph_varname=$1, dists_varname=$2, i=$3
define(`_dijkstra_inner',
`ifelse(eval($3 < array2_get(`$1', u, `length')), 1,
`define(`v', array3_get(`$1', u, `edge', `$3'))dnl
ifelse(eval(index(q, `|'v`|') >= 0), 1,
`define(`alt', add(array_get(`$2', u), array3_get(`$1', u, `weight', `$3')))dnl
ifelse(eval(alt < array_get(`$2', v)), 1, `array_set(`$2', v, alt)')dnl
')dnl
_dijkstra_inner(`$1', `$2', incr($3))dnl
'dnl
)'dnl
)

dnl find_min_distance(dists_varname):
dnl   min_dist = INF
dnl   min_index = -1
dnl   for i = 0 to dists_varname["length"] - 1:
dnl     if ("|" + i + "|") in q and dists_varname[i] < min_dist:
dnl       min_dist = dists_varname[i]
dnl       min_index = i
dnl   return min_index
define(`find_min_distance', `_find_min_distance(`$1', INF, -1, 0)')

dnl dists_varname=$1, min_dist=$2, min_index=$3, i=$4
define(`_find_min_distance',
`ifelse(eval($4 >= array_get(`$1', `length')), 1, `$3',
`ifelse(eval(index(q, `|$4|') >= 0 && array_get(`$1', `$4') < $2), 1,
`_find_min_distance(`$1', array_get(`$1', `$4'), `$4', incr($4))',
`_find_min_distance(`$1', `$2', `$3', incr($4))'dnl
)'dnl
)'dnl
)

dnl add(a, b):
dnl   if a == INF or b == INF:
dnl     return INF
dnl   return a + b
define(`add', `ifelse(eval($1 == INF || $2 == INF), 1, INF, `eval($1 + $2)')')

divert(0)dnl
ifelse(eval(ARGC < 3 ||
    !parse_int_list(`weights', ARGV1) ||
    !is_valid(ARGV2) ||
    !is_valid(ARGV3)
), 1, `show_usage()')dnl
define(`num_vertices', isqrt(array_get(`weights', `length')))dnl
ifelse(validate_inputs(weights, num_vertices, ARGV2, ARGV3), 0, `show_usage()')dnl
create_graph(`weights', num_vertices, `graph')dnl
dijkstra(`graph', ARGV2, `dists')dnl
array_get(`dists', ARGV3)
