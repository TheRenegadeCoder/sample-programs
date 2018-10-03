public class Fibonacci {

    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Usage: \"java Fibonacci <term no to iterate to, with 0 as the first term number>");
            System.exit(1);
        }

        int n = Integer.parseInt(args[0]);
        int first = 0;
        int second = 1;
        int result = 0;
        for (int i = 1; i <= n; i++) {
            result = first + second;
            first = second;
            second = result;
            System.out.println(i + ": " + first);
        }
    }

}
