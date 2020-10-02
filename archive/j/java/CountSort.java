import java.util.*; // Contains all the collection classes like ArrayList, Queue, Stack and classes for other data structures

public class CountSort {

    public static ArrayList<Integer> countSort(ArrayList<Integer> numList, int k) {

        int numCount[] = new int[k + 1];
        ArrayList<Integer> sorted = new ArrayList<>();

        for(int num : numList) {
            // Initially numCount will be an array of all zeros
            // We will store count of each number
            numCount[num] += 1; 
        }


        for(int i = 1; i < k + 1; i++) {
            numCount[i] = numCount[i] + numCount[i - 1];
        }

        // Initialize sorted array to zero
        // This is done so that sorted can be modified at indices other than zero
        for (int i = 0; i < numList.size(); i++) {
            sorted.add(0);
        }

        for(int i = numList.size() - 1; i >= 0; i--) {
            sorted.set(numCount[numList.get(i)] - 1, numList.get(i));
            --numCount[numList.get(i)];
        }

        return sorted;
    }

    public static void main(String args[]) {

        /*
        
        Important : Counting sort depends on the fact that you know what the range of the input numbers.

        Things to note:
        1. Input format be string of atleast 2 numbers in the form 1, 2, 3, 4, 5 
        2. The last number will be range specifier k
        3. Input will be from range 0 to k
        
        */



        ArrayList<Integer> numList = new ArrayList<>(); // creating an arraylist(for dynamic size) to store the numbers

        if (args.length < 1) { // null input
            System.out.println(
                    "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\" where the last integer is the range k (0 to k)");
        }

        else if (args[0].length() < 2) { // checking for empty input and single number input

            System.out.println(
                    "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\" where the last integer is the range k (0 to k)");
        } else {
            String[] stringList = args[0].split(","); // extract numbers from the passed string

            if (stringList.length < 2) { // wrong/invalid input format
                System.out.println(
                        "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\" where the last integer is the range k (0 to k)");
            } else {

                for (int i = 0; i < stringList.length - 1; i++) {
                    numList.add(Integer.parseInt(stringList[i].trim())); // convert to Int type and store in numList for
                                                                         // sorting
                }

                int k = Integer.parseInt(stringList[stringList.length - 1].trim());

                if (numList.size() < 2) { // wrong/invalid input format
                    System.out.println(
                            "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\" where the last integer is the range k (0 to k)");
                } else {
                    ArrayList<Integer> result = countSort(numList, k);
                    System.out.println("Sorted Array:");
                    System.out.println(result.toString());
                }
            }

        }

    }
}
