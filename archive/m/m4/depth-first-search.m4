divert(-1)
define(`show_usage',
`Usage: please provide a tree in an adjacency matrix form 'dnl
`("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") 'dnl
`together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4")
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

dnl create_graph(conn_mtx_varname, vert_varname, graph_varname):
dnl   // Create nodes
dnl   graph_varname["length"] = vert_varname["length"]
dnl   for i = 0 to conn_vert["length"] - 1:
dnl     graph_varname[i]["value"] = vert_varname[i]
dnl     graph_varname[i]["length"] = 0
dnl
dnl   // Connect children to nodes
dnl   idx = 0
dnl   for i = 0 to vert_varname["length"] - 1:
dnl     for j = 0 to vert_varname["length"] - 1:
dnl       if conn_mtx_varname[idx] > 0:
dnl         graph_varname[i][graph_varname[i]["length"]] = j
dnl         graph_varname[i]["length"] = graph_varname[i]["length"] + 1
dnl
dnl     idx = idx + 1
define(`create_graph',
`array_set(`$3', `length', array_get(`$2', `length'))dnl
_create_nodes(`$2', `$3', 0)dnl
_connect_children(`$1', `$2', `$3', 0, 0)dnl
'dnl
)

dnl vert_varname=$1, graph_varname=$2, i=$3
define(`_create_nodes',
`ifelse(eval($3 < array_get(`$1', `length')), 1,
`array2_set(`$2', `$3', `value', array_get(`$1', `$3'))dnl
array2_set(`$2', `$3', `length', 0)dnl
_create_nodes(`$1', `$2', incr($3))'dnl
)'dnl
)

dnl conn_mtx_varname=$1, vert_varname=$2, graph_varname=$3, i=$4, idx=$5
define(`_connect_children',
`ifelse(eval($4 < array_get(`$2', `length')), 1,
`_connect_children_inner(`$1', `$2', `$3', `$4', `$5', 0)dnl
_connect_children(`$1', `$2', `$3', incr($4), eval($5 + array_get(`$2', `length')))'dnl
)'dnl
)

dnl conn_mtx_varname=$1, vert_varname=$2, graph_varname=$3, i=$4, idx=$5, j=$6
define(`_connect_children_inner',
`ifelse(eval($6 < array_get(`$2', `length')), 1,
`ifelse(eval(array_get(`$1', $5) + 0 > 0), 1,
`array2_set(`$3', `$4', array2_get(`$3', `$4', `length'), `$6')dnl
array2_set(`$3', `$4', `length', incr(array2_get(`$3', `$4', `length')))'dnl
)dnl
_connect_children_inner(`$1', `$2', `$3', `$4', incr($5), incr($6))'dnl
)'dnl
)

dnl depth_first_search(graph_varname, target):
dnl   // Indicate nothing visited
dnl   visited = ""
dnl
dnl   // Indicate node not found
dnl   found_node = -1
dnl
dnl   // Start depth first search at root (node 0)
dnl   depth_first_search_rec(graph_varname, target, 0)
dnl
dnl  return found_node
define(`depth_first_search',
`pushdef(`visited', `')dnl
pushdef(`found_node', `-1')dnl
depth_first_search_rec(`$1', `$2', 0)dnl
popdef(`visited')dnl
found_node`'dnl
popdef(`found_node')'dnl
)

dnl depth_first_search_rec(graph_varname, target, node):
dnl   // Note: visited is a string that looks like this: "|<node1>||<node2>|..."
dnl   // Since M4 does not have anything like a set, this is the easiest way to
dnl   // represent it, and the "index" function can be used to see if a node has
dnl   // been visited (negative if not visited)
dnl
dnl   // If target value found, indicate node found
dnl   if graph_varname[node]["value"] == target:
dnl     found_node = node
dnl   else:
dnl     // Indicate node is visited
dnl     visited = visited + "|" + node + "|"
dnl
dnl     // For each child node
dnl     for i = 0 to graph_varname[node]["length"] - 1
dnl       // If child node not visited
dnl       if "|" + graph_varname[node][i] + "|" not in visited:
dnl         // Recursively check this child node
dnl         depth_first_search_rec(graph_varname, target, graph_varname[node][i])
dnl
dnl         // Exit loop if node found
dnl         if found_node >= 0:
dnl           break
define(`depth_first_search_rec',
`ifelse(eval(array2_get(`$1', `$3', `value') == $2), 1,
`define(`found_node', `$3')',
`define(`visited', visited`|$3|')dnl
_depth_first_search_rec(`$1', `$2', `$3', 0)'dnl
)'dnl
)

dnl graph_varname=$1, target=$2, node=$3, i=$4
define(`_depth_first_search_rec',
`ifelse(eval(found_node < 0 && $4 < array2_get(`$1', `$3', `length')), 1,
`ifelse(eval(index(visited, `|'array2_get(`$1', `$3', `$4')`|') < 0), 1,
`depth_first_search_rec(`$1', `$2', array2_get(`$1', `$3', `$4'))'dnl
)dnl
_depth_first_search_rec(`$1', `$2', `$3', incr($4))'dnl
)'dnl
)

divert(0)dnl
ifelse(eval(ARGC < 3 || 
    !parse_int_list(`conn_mtx', ARGV1) ||
    !parse_int_list(`vert', ARGV2) ||
    !is_valid(ARGV3)
), 1, `show_usage()')dnl
create_graph(`conn_mtx', `vert', `graph')dnl
define(`node', depth_first_search(`graph', ARGV3))dnl
ifelse(eval(node >= 0), 1, `true', `false')
