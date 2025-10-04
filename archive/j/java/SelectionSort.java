import java.util.ArrayList;

public class SelectionSort {

    public static void main(String[] args) {
        try {
            ArrayList<Integer> listOfNumbers = new ArrayList<>();
            String[] NumberArray = args[0].split(",");
            for (String Number : NumberArray) {
                listOfNumbers.add(Integer.parseInt(Number.trim()));
            }
            if (listOfNumbers.size() >= 2) {
                StringBuilder output = new StringBuilder();
                ArrayList<Integer> SortedList = sort(listOfNumbers);

                for (Integer Number : SortedList) {
                    if (SortedList.indexOf(Number) == 0) {
                        output.append(Number);
                    } else {
                        output.append(", ").append(Number);
                    }
                }
                System.out.println(output);
            } else {
                System.out.println(
                        "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
            }
        } catch (Exception e) {
            System.out.println(
                    "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
        }
    }

    private static ArrayList<Integer> sort(ArrayList<Integer> list) {
        for (int i = 0; i < list.size() - 1; i++) {
            for (int j = i + 1; j < list.size(); j++) {
                if (list.get(j) < list.get(i)) {
                    int memory = list.get(i);
                    list.set(i, list.get(j));
                    list.set(j, memory);
                }
            }
        }
        return list;
    }
}