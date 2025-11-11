divert(-1)
define(`show_usage',
`Usage: please provide a comma-separated list of integers
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

dnl n=$1, prev2=$2, prev1=$3
define(`_isqrt',
`define(`x1', eval(($3 + $1 / $3) >> 1))dnl
ifelse(eval(x1 == $3), 1, x1,
`ifelse(eval(x1 == $2 && x1 != $3), 1, `min(`$3', x1)', `_isqrt(`$1', `$3', x1)')'dnl
)'dnl
)

dnl min(a, b)
define(`min', `ifelse(eval($1 < $2), 1, $1, $2)')

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

dnl Prim's Minimum Spanning Tree (MST) Algorithm based on C implementation of
dnl https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/
dnl prim_mst(graph_varname, mst_varname):
dnl   // Note: mst_set is a string that looks like this: "|<node1>||<node2>|..."
dnl   // Since M4 does not have anything like a set, this is the easiest way to
dnl   // represent it, and the "index" function can be used to see if a node is
dnl   // in the MST (non-negative if so)
dnl
dnl   // Indicate nothing in MST, and initialize key values to infinite
dnl   mst_set = ""
dnl   mst_varname["length"] = graph_varname["length"]
dnl   for i = 0 to mst_varname["length"] - 1:
dnl     mst_varname[i]["key"] = INF
dnl
dnl   // Include first vertex in MST
dnl   mst_varname[0]["key"] = 0
dnl   mst_varname[0]["parent"] = -1  // Root has no parent
dnl
dnl   // For each vertex
dnl   for i = 1 to mst_varname["length"] - 1
dnl     // Pick index of the minimum key value not already in MST
dnl     u = find_min_key(mst_varname)
dnl
dnl     // Add picked vertex to MST set
dnl     mst_set = mst_set + "|" + u + "|"
dnl
dnl     // Update key values and parent indices of picked adjacent
dnl     // vertices. Only consider vertices not yet in MST set
dnl     for j = 0 to graph[u]["length"] - 1:
dnl       v = graph[u]["edge"][j]
dnl       w = graph[u]["weight"][j]
dnl       if ("|" + v + "|") not in mst_set and w < mst_varname[v]["key"]:
dnl         mst_varname[v]["parent"] = u
dnl         mst_varname[v]["key"] = w
define(`prim_mst',
`pushdef(`u', `')dnl
pushdef(`v', `')dnl
pushdef(`w', `')dnl
define(`mst_set', `')dnl
array_set(`$2', `length', array_get(`$1', `length'))dnl
_init_mst(`$2', 0)dnl
array2_set(`$2', 0, `key', 0)dnl
array2_set(`$2', 0, `parent', -1)dnl
_prim_mst_outer(`$1', `$2', 1)dnl
popdef(`w')dnl
popdef(`v')dnl
popdef(`u')dnl
'dnl
)

dnl mst_varname=$1, i=$2
define(`_init_mst',
`ifelse(eval($2 < array_get(`$1', `length')), 1,
`array2_set(`$1', `$2', `key', INF)dnl
_init_mst(`$1', incr($2))'dnl
)'dnl
)

dnl graph_varname=$1, mst_varname=$2, i=$3
define(`_prim_mst_outer',
`ifelse(eval($3 < array_get(`$2', `length')), 1,
`define(`u', find_min_key(`$2'))dnl
define(`mst_set', mst_set`|'u`|')dnl
_prim_mst_inner(`$1', `$2', 0)dnl
_prim_mst_outer(`$1', `$2', incr($3))dnl
'dnl
)'dnl
)

dnl graph_varname=$1, mst_varname=$2, j=$3
define(`_prim_mst_inner',
`ifelse(eval($3 < array2_get(`$1', u, `length')), 1,
`define(`v', array3_get(`$1', u, `edge', `$3'))dnl
define(`w', array3_get(`$1', u, `weight', `$3'))dnl
ifelse(eval(index(mst_set, `|'v`|') < 0 && w < array2_get(`$2', v, `key')), 1,
`array2_set(`$2', v, `parent', u)dnl
array2_set(`$2', v, `key', w)dnl
')dnl
_prim_mst_inner(`$1', `$2', incr($3))dnl
'dnl
)'dnl
)

dnl find_min_key(mst_varname):
dnl   min_key = INF
dnl   min_index = -1
dnl   for i = 0 to mst_varname["length"] - 1:
dnl     if ("|" + i + "|") not in mst_set and mst_varname[i]["key"] < min_dist:
dnl       min_key = mst_varname[i]["key"]
dnl       min_index = i
dnl   return min_index
define(`find_min_key', `_find_min_key(`$1', INF, -1, 0)')

dnl mst_varname=$1, min_key=$2, min_index=$3, i=$4
define(`_find_min_key',
`ifelse(eval($4 >= array_get(`$1', `length')), 1, `$3',
`ifelse(eval(index(mst_set, `|$4|') < 0 && array2_get(`$1', `$4', `key') < $2), 1,
`_find_min_key(`$1', array2_get(`$1', `$4', `key'), `$4', incr($4))',
`_find_min_key(`$1', `$2', `$3', incr($4))'dnl
)'dnl
)'dnl
)

dnl get_total_mst_weight(mst_varname):
dnl   total = 0
dnl   for i = 1 to mst_varname["length"] - 1:
dnl     total = total + mst_varname[i]["key"]
dnl   return total
define(`get_total_mst_weight', `_get_total_mst_weight(`$1', 0, 1)')

dnl mst_varname=$1, total=$2, i=$3
define(`_get_total_mst_weight',
`ifelse(eval($3 >= array_get(`$1', `length')), 1, `$2',
`_get_total_mst_weight(`$1', eval($2 + array2_get(`$1', `$3', `key')), incr($3))'dnl
)'dnl
)

divert(0)dnl
ifelse(eval(ARGC < 1 || !parse_int_list(`weights', ARGV1)), 1, `show_usage()')dnl
define(`num_vertices', isqrt(array_get(`weights', `length')))dnl
ifelse(eval(array_get(`weights', `length') != num_vertices * num_vertices), 1, `show_usage()')dnl
create_graph(`weights', num_vertices, `graph')dnl
prim_mst(`graph', `mst')dnl
get_total_mst_weight(`mst')
