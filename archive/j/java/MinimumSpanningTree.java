import java.util.Arrays;

public class MinimumSpanningTree {

    public static void main(String[] args) {
        int[] matrix = parse(args);

        int size = (int) Math.sqrt(matrix.length);
        long result = minimumSpanningTree(matrix, size);

        System.out.println(result);
    }

    private static void usage() {
        System.err.println("Usage: please provide a comma-separated list of integers");
        System.exit(1);
    }

    private static int[] parse(String[] args) {
        if (args.length != 1 || args[0] == null || args[0].isBlank()) {
            usage();
        }

        String[] tokens = args[0].split(",");
        int[] values = new int[tokens.length];

        for (int i = 0; i < tokens.length; i++) {
            String token = tokens[i].trim();
            if (token.isEmpty()) {
                usage();
            }

            try {
                values[i] = Integer.parseInt(token);
            } catch (NumberFormatException e) {
                usage();
            }
        }

        int n = (int) Math.sqrt(values.length);
        if (n * n != values.length) {
            usage();
        }

        return values;
    }

    private static long minimumSpanningTree(int[] graph, int size) {
        boolean[] inMst = new boolean[size];
        long[] minEdgeWeight = new long[size];

        Arrays.fill(minEdgeWeight, Long.MAX_VALUE);
        minEdgeWeight[0] = 0;

        long totalWeight = 0;

        for (int i = 0; i < size; i++) {
            int selectedNode = -1;
            long bestWeight = Long.MAX_VALUE;

            for (int v = 0; v < size; v++) {
                if (inMst[v] || minEdgeWeight[v] >= bestWeight) {
                    continue;
                }

                bestWeight = minEdgeWeight[v];
                selectedNode = v;
            }

            if (selectedNode == -1 || bestWeight == Long.MAX_VALUE) {
                usage();
            }

            inMst[selectedNode] = true;
            totalWeight += bestWeight;

            int rowStart = selectedNode * size;

            for (int v = 0; v < size; v++) {
                int edgeWeight = graph[rowStart + v];

                if (inMst[v] || edgeWeight <= 0 || edgeWeight >= minEdgeWeight[v]) {
                    continue;
                }

                minEdgeWeight[v] = edgeWeight;
            }
        }

        return totalWeight;
    }
}
