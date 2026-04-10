import java.util.Arrays;

public class MaximumArrayRotation {
    public static void main(String[] args) {
        int[] input = parse(args);
        System.out.println(maximumRotationSum(input));
    }

    private static void usage() {
        System.err.println("Usage: please provide a list of integers (e.g. \"8, 3, 1, 2\")");
        System.exit(1);
    }

    private static int[] parse(String[] args) {
        if (args.length != 1 || args[0] == null || args[0].isBlank()) {
            usage();
        }

        try {
            int[] values = Arrays.stream(args[0].split(","))
                    .map(String::trim)
                    .mapToInt(Integer::parseInt)
                    .toArray();

            if (values.length == 0) {
                usage();
            }

            return values;

        } catch (NumberFormatException e) {
            usage();
            return new int[0]; // unreachable
        }
    }

    private static long maximumRotationSum(int[] values) {
        int n = values.length;
        if (n == 0) {
            usage();
        }

        long sum = 0;
        long currentSum = 0;

        for (int i = 0; i < n; i++) {
            sum += values[i];
            currentSum += (long) values[i] * i;
        }

        long maxSum = currentSum;

        for (int i = 1; i < n; i++) {
            currentSum += sum - (long) n * values[n - i];
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}