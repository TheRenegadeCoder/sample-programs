public class PalindromicNumber {

    public static void main(String[] args) {
        Long num;
        try {
            num = Long.parseLong(args[0]);
        } catch (Exception ignored) {
            num = null;
        }

        if (num == null || num.toString().length() < 2) {
            System.out.println("Usage: please input a number with at least two digits");
        } else {
            System.out.println(isPalindromic(num));
        }
    }

    /**
     * Checks if the number is palindromic or not
     */
    public static boolean isPalindromic(Long num) {
        char[] numChars = String.valueOf(num).toCharArray();
        for (int i = 0; i < numChars.length / 2; i++) {
            if (numChars[i] != numChars[numChars.length - 1 - i])
                return false;
        }
        return true;
    }
}
