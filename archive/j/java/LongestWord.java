import java.util.*;

class LongestWord {
    public static void error() {
        System.out.println("Usage: please provide a string");
    }

    public static void main(String[] args) {
        if (args.length <= 0) {
            error();
        } else if (args[0].length() == 0) {
            error();
        } else {
            String inputStr = args[0];
            String[] words = inputStr.split("\\s+");
            int max = -1;
            for (String word : words) {
                if (word.length() > max) {
                    max = word.length();
                }
            }
            System.out.println(max);
        }
    }
}