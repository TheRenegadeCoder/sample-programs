public class Fibonacci {

    public static void main(String[] args) {
        try {
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
        } catch (Exception e) {
            System.out.println("Usage: please input the count of fibonacci numbers to output");
            System.exit(1);
        }
    }

}
