public class LongestPalindromicSubstring {

    private static final String usage_msg = "Usage: please provide a string that contains at least one palindrome\n";

    private static int expandAroundCenter(String s, int left, int right) {
        while (left >= 0 && right < s.length() && s.charAt(left) == s.charAt(right)) {
            left--;
            right++;
        }
        return right - left - 1;
    }

    private static boolean longestPalindromicSubstring(String s, StringBuilder result) {
        if (s == null || s.isEmpty()) {
            result.setLength(0);
            return false;
        }

        int start = 0, maxLength = 0;
        int len = s.length();

        for (int i = 0; i < len; i++) {
            int len1 = expandAroundCenter(s, i, i);
            int len2 = expandAroundCenter(s, i, i + 1);
            int currLen = Math.max(len1, len2);

            if (currLen > maxLength) {
                start = i - (currLen - 1) / 2;
                maxLength = currLen;
            }
        }

        if (maxLength > 1) {
            result.setLength(0);
            result.append(s.substring(start, start + maxLength));
            return true;
        }

        result.setLength(0);
        return false;
    }

    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.print(usage_msg);
            System.exit(1);
        }

        String input = args[0];
        StringBuilder result = new StringBuilder();

        if (longestPalindromicSubstring(input, result) && result.length() > 0) {
            System.out.println(result);
        } else {
            System.out.print(usage_msg);
        }
    }
}
