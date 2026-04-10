public class RomanNumeral {
    private static final int[] ROMAN = new int[128];

    static {
        ROMAN['I'] = 1;
        ROMAN['V'] = 5;
        ROMAN['X'] = 10;
        ROMAN['L'] = 50;
        ROMAN['C'] = 100;
        ROMAN['D'] = 500;
        ROMAN['M'] = 1000;
    }

    public static void main(String[] args) {
        if (args.length == 0 || args[0] == null || args[0].isEmpty()) {
            System.out.println("Usage: please provide a string of roman numerals");
            System.exit(1);
        }

        String s = args[0].toUpperCase();

        int result = romanToInt(s);
        if (result == -1) {
            System.err.println("Error: invalid string of roman numerals");
            System.exit(1);
        }

        System.out.println(result);
    }

    private static int romanToInt(String input) {
        int total = 0;
        int prev = 0;

        for (int i = input.length() - 1; i >= 0; i--) {
            char c = input.charAt(i);

            if (c >= 128 || ROMAN[c] == 0) {
                return -1;
            }

            int cur = ROMAN[c];

            if (cur < prev) {
                total -= cur;
            } else {
                total += cur;
            }

            prev = cur;
        }

        return total;
    }
}