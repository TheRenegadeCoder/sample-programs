function usage() {
    print "Usage: please provide three inputs: a serialized matrix, a source node and a destination node"
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

function validate_inputs(weights, num_weights, num_vertices, src, dest,  i, any_non_zero) {
    # Verify number of weights is a square, source and destination are valid
    if (num_weights != num_vertices * num_vertices || \
        src < 0 || src >= num_vertices || \
        dest < 0 || dest >= num_vertices) {
        return 0
    }

    # Verify weights greater than equal to zero and any non-zero weights
    any_non_zero = 0
    for (i = 1; i <= num_weights; i++) {
        if (weights[i] < 0) {
            return 0
        }

        if (weights[i] > 0) {
            any_non_zero = 1
        }
    }

    return any_non_zero
}

function create_graph(weights, num_vertices, graph,  u, v, idx) {
    idx = 0
    for (u = 0; u < num_vertices; u++) {
        for (v = 0; v < num_vertices; v++) {
            idx++
            if (weights[idx] > 0) {
                graph[u][v] = weights[idx]
            }
        }
    }
}

# Source: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode
function dijkstra(graph, src, dists, prevs,  u, v, q, alt) {
    # Initialize distances to infinite and previous vertices to undefined
    # Initialize unvisited nodes
    for (v in graph) {
        dists[v] = 1e999 # Awk doesn't have infinity, so use large integer
        prevs[v] = 0
        q[v] = 1
    }

    # Set first vertex distance to 0
    dists[src] = 0

    # While any unvisited nodes
    while (length(q) > 0) {
        # Pick a vertex u in Q with minimum distance
        u = find_min_distance(dists, q)

        # Remove vertex u from Q
        delete q[u]

        # For each neighbor v of vertex u still in Q
        for (v in graph[u]) {
            if (v in q) {
                # Get trial distance
                alt = dists[u] + graph[u][v]

                # If trial distance is smaller than distance v, update distance to v and
                # previous vertex of v
                if (alt < dists[v]) {
                    dists[v] = alt
                    prevs[v] = u
                }
            }
        }
    }
}

function find_min_distance(dists, q,  min_dist, min_index, v) {
    min_dist = 1e999
    min_index = -1
    for (v in q) {
        if (dists[v] < min_dist) {
            min_dist = dists[v]
            min_index = v
        }
    }

    return min_index
}

BEGIN {
    if (ARGC < 4) {
        usage()
    }

    str_to_array(ARGV[1], weights)
    num_weights = length(weights)
    src = str_to_number(ARGV[2])
    dest = str_to_number(ARGV[3])
    if (!num_weights || weights[1] == "ERROR" || src == "ERROR" || dest == "ERROR") {
        usage()
    }

    num_vertices = int(sqrt(num_weights) + 0.5)
    if (!validate_inputs(weights, num_weights, num_vertices, src, dest)) {
        usage()
    }

    create_graph(weights, num_vertices, graph)
    dijkstra(graph, src, dists, prevs)
    print dists[dest]
}
