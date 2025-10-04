import sys
import math

def usage():
    print("Usage: please provide three inputs: a serialized matrix, a source node and a destination node")
    sys.exit(0)

def parse_int_list(s):
    return [int(x.strip()) for x in s.split(",")]

def validate_inputs(weights, num_vertices, src, dest):
    # Verify number of weights is a square
    if len(weights) != num_vertices * num_vertices:
        return False

    # Verify weights greater than equal to zero
    if any(weight < 0 for weight in weights):
        return False

    # Verify any non-zero weights
    if not any(weights):
        return False

    # Verify source and destination are in range
    if src < 0 or src >= num_vertices or dest < 0 or dest >= num_vertices:
        return False

    return True

class Graph:
    def __init__(self, num_vertices):
        self.num_vertices = num_vertices
        self.edges = [{} for i in range(num_vertices)]

    def add_node(self, u, v, weight):
        self.edges[u][v] = weight

def create_graph(num_vertices, weights):
    graph = Graph(num_vertices)
    index = 0
    for u in range(num_vertices):
        for v in range(num_vertices):
            if weights[index]:
                graph.add_node(u, v, weights[index])

            index += 1

    return graph

def dijkstra(graph, src):
    # Source: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#Pseudocode

    # Initialize distances to infinite and previous vertices to undefined
    # Set source vertex distance to 0
    dists = [sys.maxsize] * graph.num_vertices
    prevs = [-1] * (graph.num_vertices)
    dists[src] = 0

    # Initialize unvisited nodes
    q = set(range(graph.num_vertices))

    # While any unvisited nodes
    while q:
        # Pick a vertex u in Q with minimum distance
        _, u = min(
            (dist, vertex) for vertex, dist in enumerate(dists) if vertex in q
        )

        # Remove vertex u from Q
        q.remove(u)

        # For each neighbor v of vertex u in still in Q
        for v, weight in graph.edges[u].items():
            if v in q:
                # Get trial distance
                alt = dists[u] + weight

                # If trial distance is smaller than distance v, update distance to v and
                # previous vertex of v
                if alt < dists[v]:
                    dists[v] = alt
                    prevs[v] = u

    return dists, prevs

def main():
    if len(sys.argv) < 4:
        usage()

    # Parse inputs
    try:
        weights = parse_int_list(sys.argv[1])
        src = int(sys.argv[2])
        dest = int(sys.argv[3])
    except ValueError:
        usage()

    # Validate inputs
    num_vertices = int(math.sqrt(len(weights) + 0.5))
    if not validate_inputs(weights, num_vertices, src, dest):
        usage()

    # Create graph from weights
    graph = create_graph(num_vertices, weights)

    # Run Dijkstra's algorithm on graph and show distance to destination
    dists, _ = dijkstra(graph, src)
    print(dists[dest])

if __name__ == "__main__":
    main()
