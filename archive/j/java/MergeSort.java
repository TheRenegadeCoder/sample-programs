import java.util.ArrayList;

public class MergeSort {

    public static void main(String[] args) {

        ArrayList<Integer> numList = new ArrayList<>(); // creating an arraylist(for dynamic size) to store the numbers

        if (args.length < 1) { // null input
            System.out.println(
                    "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
        }

        else if (args[0].length() < 2) { // checking for empty input and single number input

            System.out.println(
                    "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
        } else {
            String[] stringList = args[0].split(","); // extract numbers from the passed string

            if (stringList.length < 2) { // wrong/invalid input format
                System.out.println(
                        "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
            } else {

                for (int i = 0; i < stringList.length; i++) {
                    numList.add(Integer.parseInt(stringList[i].trim())); // convert to Int type and store in numList for
                                                                         // sorting
                }

                if (numList.size() < 2) { // wrong/invalid input format
                    System.out.println(
                            "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
                } else {
                    mergeSort(numList, 0, numList.size() - 1);

                    // display the sorted list to the user
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

    public static void mergeSort(ArrayList<Integer> numList, int low, int high) {

        if (low < high) {
            // calculating mid avoiding overflow
            int mid = low + (high - low) / 2;

            // recursively divide the list into 2 parts and call mergeSort on each half
            mergeSort(numList, low, mid);
            mergeSort(numList, mid + 1, high);

            // finally merge the sorted halves to get the final sorted list
            mergeList(numList, low, mid, high);

        }

    }

    public static void mergeList(ArrayList<Integer> numList, int low, int mid, int high) {

        int i = low;
        int j = mid + 1;
        int k = low;
        ArrayList<Integer> copyList = new ArrayList(numList);
        // find the smaller element using pointers,update the array and move the pointer
        // forward
        while (i <= mid && j <= high) { // till we don't reach the end of individual arrays

            if (copyList.get(i) <= copyList.get(j)) {
                numList.set(k, copyList.get(i));
                i++; // incrementing pointer
            } else {
                numList.set(k, copyList.get(j));
                j++; // incrementing pointer
            }

            k++; // incrementing arraylist index
        }

        // dealing with cases where we reach end of one part; just copy the remaining
        // part of second half
        while (i <= mid) {
            numList.set(k, copyList.get(i));
            i++;
            k++;
        }

        while (j <= high) {
            numList.set(k, copyList.get(j));
            j++;
            k++;
        }
    }

}
