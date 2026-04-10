import java.util.*;
import java.util.stream.Collectors;

public class Zeckendorf {
    public static void main(String[] args) {
        try {
            if (args.length == 0 || args[0].isBlank()) {
                throw new Exception();
            }

            long n = Long.parseLong(args[0].trim());
            if (n < 0) throw new Exception();

            if (n == 0) {
                System.out.println("");
                return;
            }

            System.out.println(formatResult(getZeckendorf(n)));

        } catch (Exception e) {
            System.out.println("Usage: please input a non-negative integer");
        }
    }

    private static List<Long> getZeckendorf(long target) {
        List<Long> fibs = new ArrayList<>();
        long a = 1;
        long b = 2;

        fibs.add(a);
        while (b <= target) {
            fibs.add(b);
            long next = a + b;
            a = b;
            b = next;
        }

        List<Long> selected = new ArrayList<>();
        long remaining = target;

        for (int i = fibs.size() - 1; i >= 0 && remaining > 0; i--) {
            long currentFib = fibs.get(i);

            if (currentFib <= remaining) {
                selected.add(currentFib);
                remaining -= currentFib;
                i--;
            }
        }

        return selected;
    }

    private static String formatResult(List<Long> result) {
        return result.stream().map(String::valueOf).collect(Collectors.joining(", "));
    }
}