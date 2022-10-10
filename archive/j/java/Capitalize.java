public class Capitalize {

    public static boolean isLetter(char someChar) {
        return (someChar >= 'a' && someChar <= 'z') || (someChar >= 'A' && someChar <= 'Z');
    }

    public static boolean isUpperCase(char someChar) {
        return (someChar >= 'A' && someChar <= 'Z');
    }

    public static void main(String[] args) {
        if (args.length == 0 || args[0].equals("")) {
            System.out.println("Usage: please provide a string");
            System.exit(1);
        }
        String sentence = args[0];

        char firstChar = sentence.charAt(0);
        if (isLetter(firstChar) && !isUpperCase(firstChar)) {
            char[] charArray = sentence.toCharArray();
            charArray[0] = Character.toUpperCase(firstChar);
            sentence = new String(charArray);
        }
        System.out.println(sentence);

    }
}
