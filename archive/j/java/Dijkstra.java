import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Stream;

public class Dijkstra {
    private static final int INF = Integer.MAX_VALUE;

    public static void main(String[] args) {
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

            if (sourceNode < 0 || sourceNode >= size ||
                    targetNode < 0 || targetNode >= size) {
                throw new IllegalArgumentException();
            }

            int result = findShortestPath(weights, size, sourceNode, targetNode);
            System.out.println(result);

        } catch (Exception e) {
            System.err.println(
                    "Usage: please provide three inputs: a serialized matrix, a source node and a destination node"
            );
        }
    }

    private static int[] parseWeights(String input) {
        return Pattern.compile(",")
                .splitAsStream(input)
                .map(String::trim)
                .mapToInt(s -> {
                    int w = Integer.parseInt(s);
                    if (w < 0) throw new IllegalArgumentException();
                    return w;
                })
                .toArray();
    }

    record Node(int id, int cost) implements Comparable<Node> {
        public int compareTo(Node o) {
            return Integer.compare(this.cost, o.cost);
        }
    }

    private static int findShortestPath(int[] matrix, int n, int start, int target) {
        if (start == target) return 0;

        int[] dist = new int[n];
        Arrays.fill(dist, INF);
        dist[start] = 0;

        PriorityQueue<Node> pq = new PriorityQueue<>();
        pq.add(new Node(start, 0));

        while (!pq.isEmpty()) {
            Node cur = pq.poll();
            int u = cur.id();

            if (cur.cost() > dist[u]) continue;
            if (u == target) return dist[u];

            for (int v = 0; v < n; v++) {
                int w = matrix[u * n + v];
                if (w <= 0) continue;

                int nd = dist[u] + w;

                if (nd >= dist[v]) continue;

                dist[v] = nd;
                pq.add(new Node(v, nd));
            }
        }

        throw new NoSuchElementException();
    }
}