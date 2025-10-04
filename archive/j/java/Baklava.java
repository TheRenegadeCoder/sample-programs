public class Baklava {
    public static void up() {
        for (int i = 0; i < 10; i++)
            printRow(i);
    }

    public static void down() {
        for (int i = 10; i >= 0; i--)
            printRow(i);
    }

    public static void printRow(int rowNum) {
        for (int j = 10 - rowNum; j > 0; j--)
            System.out.print(" ");
        for (int j = 0; j <= rowNum * 2; j++)
            System.out.print("*");
        System.out.println();
    }

    public static void main(String[] args) {
        up();
        down();
    }
}
