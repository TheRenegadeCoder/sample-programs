public class ReverseString {
    public static void main(String args[]) {
        if (args.length > 0) {
            StringBuilder builder = new StringBuilder(args[0]);
            String reversed = builder.reverse().toString();
            System.out.println(reversed);
        }
    }
}
