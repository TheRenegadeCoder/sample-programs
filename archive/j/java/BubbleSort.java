import java.util.Scanner;

class BubbleSort {

    public static void main(String[] args) {
        int c, d, swap;
        String inputString = "";
        Scanner in = new Scanner(System.in);
        System.out.println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
        inputString = in.nextLine();
        inputString = inputString.trim();
        String[] unsortedString = new String[inputString.length()];

        if (inputString.matches("[\\d,]+")) {

            unsortedString = inputString.split(",");
            System.out.println(unsortedString[0] + "," + unsortedString[2]);

            int size = unsortedString.length;
            int[] arr = new int[size];
            for (int i = 0; i < size; i++) {
                arr[i] = Integer.parseInt(unsortedString[i]);
                System.out.println(arr[i]);
            }
            for (c = 0; c < (arr.length - 1); c++) {
                for (d = 0; d < arr.length - c - 1; d++) {
                    if (arr[d] > arr[d + 1]) {
                        swap = arr[d];
                        arr[d] = arr[d + 1];
                        arr[d + 1] = swap;
                    }
                }
            }

            for (c = 0; c < arr.length; c++) {
                System.out.print(arr[c]);
                if (c == arr.length - 1) {
                } else {
                    System.out.print(",");
                }
            }
        } else {

            System.out.println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");

        }
    }
}
