public class Factorial {
    public static long fact(long n) {
        if (n <= 0)
            return 1;
        return n * fact(n - 1);
    }

    public static void main(String[] args) {
        try {
            long n = Long.parseLong(args[0]);
            if (n > 59) {
                System.out.println(String.format("%1$s! is out of the reasonable bounds for calculation.", n));
                System.exit(1);
            } else if (n < 0) {
                System.out.println("Usage: please input a non-negative integer");
                System.exit(1);
            }
            long result = fact(n);
            System.out.println(result);
        } catch (Exception e) {
            System.out.println("Usage: please input a non-negative integer");
            System.exit(1);
        }
    }
}
