import java.util.*;

public class JosephusProblem {

    private static int josephus(int n, int k) {
        if (n == 1) return 1;
        return (josephus(n - 1, k) + k - 1) % n + 1;
    }

    public static void main(String[] args) {
        final String usage_msg = "Usage: please input the total number of people and number of people to skip.\n";

        if (args.length != 2) {
            System.err.print(usage_msg);
            System.exit(1);
        }

        int n=0, k=0;
        try {
            n = Integer.parseInt(args[0]);
            k = Integer.parseInt(args[1]);
        } catch (NumberFormatException e) {
            System.err.print(usage_msg);
            System.exit(1);
        }

        if (n <= 0 || k <= 0) {
            System.err.print(usage_msg);
            System.exit(1);
        }

        int result = josephus(n, k);
        System.out.println(result);
    }
}
