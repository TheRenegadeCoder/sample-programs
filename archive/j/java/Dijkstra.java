import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.*;

public class Dijkstra {
    final int INF = Integer.MAX_VALUE;

    void main(String[] args) {
        try {
            if (args.length != 3 || Stream.of(args).anyMatch(String::isBlank)) {
                throw new IllegalArgumentException();
            }

            final int[] weights = parseWeights(args[0]);
            final int size = (int) Math.round(Math.sqrt(weights.length));

            if (size * size != weights.length || size == 0) {
                throw new IllegalArgumentException();
            }

            final int sourceNode = Integer.parseInt(args[1].trim());
            final int targetNode = Integer.parseInt(args[2].trim());

            if (sourceNode < 0 || sourceNode >= size || targetNode < 0 || targetNode >= size) {
                throw new IllegalArgumentException();
            }

            int result = findShortestPath(weights, size, sourceNode, targetNode);
            System.out.println(result);

        } catch (Exception _) {
            System.err.println("Usage: please provide three inputs: a serialized matrix, a source node and a destination node");
        }
    }

    private int[] parseWeights(String input) {
        return Pattern.compile(",")
                .splitAsStream(input)
                .map(String::trim)
                .mapToInt(s -> {
                    int w = Integer.parseInt(s);
                    if (w < 0) {
                        throw new IllegalArgumentException();
                    }
                    return w;
                })
                .toArray();
    }

    record Node(int id, int cost) implements Comparable<Node> {
        @Override
        public int compareTo(Node other) {
            return Integer.compare(this.cost, other.cost);
        }
    }

    private int findShortestPath(int[] matrix, int nodeCount, int start, int target) {
        if (start == target) {
            return 0;
        }

        int[] minCosts = new int[nodeCount];
        Arrays.fill(minCosts, INF);
        minCosts[start] = 0;

        var pq = new PriorityQueue<Node>();
        pq.add(new Node(start, 0));

        while (!pq.isEmpty()) {
            Node current = pq.poll();
            int u = current.id();

            if (current.cost() > minCosts[u]) {
                continue;
            }

            if (u == target) {
                return minCosts[u];
            }

            for (int v = 0; v < nodeCount; v++) {
                int weight = matrix[u * nodeCount + v];
                if (weight <= 0) {
                    continue;
                }

                int totalCost = minCosts[u] + weight;

                if (totalCost < 0 || totalCost >= minCosts[v]) {
                    continue;
                }

                minCosts[v] = totalCost;
                pq.add(new Node(v, totalCost));

            }
        }

        if (minCosts[target] == INF) {
            throw new NoSuchElementException();
        }

        return minCosts[target];
    }
}