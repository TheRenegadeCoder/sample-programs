import java.util.Arrays;

public class MaximumSubarray {

    public static void main(String[] args) {
        int[] input = parse(args);
        System.out.println(maximumSubarraySum(input));
    }

    private static void usage() {
        System.err.println("Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\"");
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


    private static long maximumSubarraySum(int[] numbers) {
        if (numbers.length == 0) {
            return 0;
        }

        int currentSum = numbers[0];
        int maxSum = numbers[0];

        for (int i = 1; i < numbers.length; i++) {
            int number = numbers[i];
            currentSum = Math.max(number, currentSum + number);
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}