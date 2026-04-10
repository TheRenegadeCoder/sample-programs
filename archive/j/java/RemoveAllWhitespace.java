public class RemoveAllWhitespace {
    public static void main(String[] args) {
        if (args.length == 0 || args[0].isEmpty()) {
            showUsage();
        }

        System.out.println(removeAllWhitespace(args[0]));
    }

    private static void showUsage() {
        System.out.println("Usage: please provide a string");
        System.exit(1);
    }

    private static boolean isWhitespace(char c) {
        return switch (c) {
            case ' ', '\t', '\n', '\r' -> true;
            default -> false;
        };
    }

    private static String removeAllWhitespace(String input) {
        var result = new StringBuilder(input.length());

        for (char c : input.toCharArray()) {
            if (!isWhitespace(c)) {
                result.append(c);
            }
        }

        return result.toString();
    }
}