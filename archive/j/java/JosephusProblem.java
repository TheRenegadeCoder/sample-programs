import java.util.*;

public class JosephusProblem {

    public static int josephus(int n, int k) {
        int res = 0;
        for (int i = 1; i <= n; i++) {
            res = (res + k) % i;
        }
        return res + 1;
    }

    public static void main(String[] args) {
        if (args.length != 2) {
            System.err.println("Usage: <n> <k>");
            System.exit(1);
        }

        try {
            int n = Integer.parseInt(args[0]);
            int k = Integer.parseInt(args[1]);
            if (n <= 0 || k <= 0) {
                System.err.println("Invalid input");
                System.exit(1);
            }
            System.out.println(josephus(n, k));
        } catch (NumberFormatException e) {
            System.err.println("Invalid input");
            System.exit(1);
        }
    }
}
