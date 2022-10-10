import java.util.*;

public class BinarySearch {
    public static void binarySearch(ArrayList<Integer> arr, int first, int last, int key) {
        int mid = (first + last) / 2;
        while (first <= last) {
            if (arr.get(mid) < key) {
                first = mid + 1;
            } else if (arr.get(mid) == key) {
                System.out.println("True");
                break;
            } else {
                last = mid - 1;
            }
            mid = (first + last) / 2;
        }
        if (first > last) {
            System.out.println("False");
        }
    }

    public static void main(String args[]) {
        try {
            ArrayList<Integer> listOfNumbers = new ArrayList<>();
            String[] NumberArray = args[0].split(",");
            for (String Number : NumberArray) {
                listOfNumbers.add(Integer.parseInt(Number.trim()));
            }
            int key = Integer.parseInt(args[1].trim());
            int last = listOfNumbers.size() - 1;
            for (int i = 0; i < last - 1; i++) {
                if (listOfNumbers.get(i) > listOfNumbers.get(i + 1)) {
                    System.out.println(
                            "Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")");
                    System.exit(1);
                }
            }
            binarySearch(listOfNumbers, 0, last, key);
        } catch (Exception e) {
            System.out.println(
                    "Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")");
        }
    }
}