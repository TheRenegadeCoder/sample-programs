public class Fibonacci {

    public static long fibonacci(int n) {
        if (n == 0) return 0;
        if (n <= 2) {
            return 1;
        } else {
            return fibonacci(n - 1) + fibonacci(n - 2);
        }
    }

    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Usage: \"java Fibonacci <term no to iterate to, with 0 as the first term number>");
            System.exit(1);
        }
        
        int n = Integer.parseInt(args[0]);
        for (int i = 0; i <= n; i++) {
            System.out.println(i + ": " + fibonacci(i));
        }
    }

}
