import java.util.*;

public class DuplicateCharacterCounter {
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
            Map<Character, Integer> map = new HashMap<>();
            for (Character c : inputStr.toCharArray()) {
                map.put(c, map.getOrDefault(c, 0) + 1);
            }
            boolean flag = false;
            for (Character c : inputStr.toCharArray()) {
                if (map.get(c) > 1) {
                    flag = true;
                    System.out.printf("%c: %d\n", c, map.get(c));
                    map.put(c, 0);
                }
            }
            if (flag == false) {
                System.out.println("No duplicate characters");
            }
        }
    }
}