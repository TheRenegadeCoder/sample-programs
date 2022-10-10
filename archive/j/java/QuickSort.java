import java.util.ArrayList;

public class QuickSort {

    public static void main(String[] args) {
        ArrayList<Integer> numList = new ArrayList<>();
        if (args.length < 1) {
            System.out.println(
                    "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
        } else if (args[0].length() < 2) {
            System.out.println(
                    "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
        } else {
            String[] stringList = args[0].split(",");
            if (stringList.length < 2) {
                System.out.println(
                        "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
            } else {
                for (int i = 0; i < stringList.length; i++) {
                    numList.add(Integer.parseInt(stringList[i].trim()));
                }
                if (numList.size() < 2) {
                    System.out.println(
                            "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
                } else {
                    sort(numList, 0, numList.size() - 1);
                    String str = "";
                    for (int i = 0; i < numList.size() - 1; i++) {
                        str += String.valueOf(numList.get(i));
                        str += ", ";
                    }
                    str += String.valueOf(numList.get(numList.size() - 1));
                    System.out.println(str);
                }
            }
        }
    }

    public static int partition(ArrayList<Integer> arr, int low, int high) {
        int pivot = arr.get(high);
        int i = (low - 1);
        for (int j = low; j < high; j++) {
            if (arr.get(j) <= pivot) {
                i++;
                int temp = arr.get(i);
                arr.set(i, arr.get(j));
                arr.set(j, temp);
            }
        }
        int temp = arr.get(i + 1);
        arr.set(i + 1, arr.get(high));
        arr.set(high, temp);
        return i + 1;
    }

    public static void sort(ArrayList<Integer> arr, int low, int high) {
        if (low < high) {
            int pi = partition(arr, low, high);
            sort(arr, low, pi - 1);
            sort(arr, pi + 1, high);
        }
    }
}