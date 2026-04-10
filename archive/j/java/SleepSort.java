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
        List<Integer> sortedList = Collections.synchronizedList(new ArrayList<>());

        ExecutorService executor = Executors.newCachedThreadPool();

        CountDownLatch latch = new CountDownLatch(input.size());

        for (int n : input) {
            executor.submit(() -> {
                try {
                    Thread.sleep(n * 100L);
                    sortedList.add(n);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                } finally {
                    latch.countDown();
                }
            });
        }

        try {
            latch.await();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        executor.shutdown();

        return sortedList;
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