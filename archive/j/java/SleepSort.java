import java.time.Duration;
import java.util.*;
import java.util.concurrent.*;
import java.util.stream.Collectors;

public class SleepSort {

    public static void main(String[] args) {
        if (args.length != 1 || args[0].isBlank()) {
            usage();
        }

        List<Integer> numbers = parse(args[0]);
        if (numbers.size() < 2) {
            usage();
        }

        List<Integer> sorted = sleepSort(numbers);

        System.out.println(format(sorted));
    }

    private static List<Integer> sleepSort(List<Integer> input) {
        var sortedList = Collections.synchronizedList(new ArrayList<Integer>());

        try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
            for (int n : input) {
                executor.submit(() -> {
                    sleepUninterruptibly(n);
                    sortedList.add(n);
                });
            }
        }

        return sortedList;
    }

    private static void sleepUninterruptibly(int value) {
        try {
            Thread.sleep(Duration.ofMillis(value * 100L));
        } catch (InterruptedException _) {
            Thread.currentThread().interrupt();
        }
    }

    private static List<Integer> parse(String input) {
        try {
            return Arrays.stream(input.split(",")).map(String::trim).map(Integer::parseInt).toList();
        } catch (Exception e) {
            usage();
            return List.of(); // Unreachable
        }
    }

    private static String format(List<Integer> list) {
        return list.stream().map(String::valueOf).collect(Collectors.joining(", "));
    }

    private static void usage() {
        System.out.println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
        System.exit(1);
    }
}