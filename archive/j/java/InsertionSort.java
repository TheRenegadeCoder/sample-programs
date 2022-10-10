import java.util.ArrayList;

public class InsertionSort {

    public static void main(String[] args) {

        ArrayList<Integer> numList = new ArrayList<>();

        if (args.length < 1) {
            System.out.println(
                    "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
        }

        else if (args[0].length() < 2) {

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
                    insertionSort(numList);
                }
            }

        }

    }

    public static void insertionSort(ArrayList<Integer> numList) {
        for (int j = 1; j < numList.size(); j++) {
            int k = j - 1, val = numList.get(j);
            while (k >= 0 && numList.get(k) > val) {

                numList.set(k + 1, numList.get(k));
                k--;
            }
            numList.set(k + 1, val);
        }
        for (int i = 0; i < numList.size() - 1; i++) {
            System.out.print(numList.get(i) + ", ");
        }
        System.out.print(numList.get(numList.size() - 1));

    }

}
