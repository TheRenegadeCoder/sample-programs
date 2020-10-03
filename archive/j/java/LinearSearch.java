import java.util.*;

public class LinearSearch {

    public static void main(String[] args) {
        try {
            ArrayList<Integer> listOfNumbers = new ArrayList<>();
            Integer keyToSearch = Integer.parseInt(args[0]);
            String[] NumberArray = args[1].split(",");
            for(String Number: NumberArray) {
                listOfNumbers.add(Integer.parseInt(Number.trim()));
            }
            if(listOfNumbers.size() >= 2){
                StringBuilder output = new StringBuilder();
                Integer searched = linearSearch(listOfNumbers, keyToSearch);
                if(searched != -1) {
                    System.out.println(keyToSearch + " found at position " + searched + ".");
                } else {
                    System.out.println(keyToSearch + " not found in the array.");
                }

            }else{
                System.out.println("Usage: please provide a list of at least two integers to search in the format \"1, 2, 3, 4, 5\"");
            }
        }
        catch(Exception e) {
            System.out.println("Usage: please provide a list of at least two integers to search in the format \"1, 2, 3, 4, 5\"");
        }
    }

    private static Integer linearSearch(ArrayList<Integer> list, Integer keyToSearch) {
        Integer ans = -1;
        for (Integer number : list) {
            if(number == keyToSearch) {
                ans = list.indexOf(number);
                break;
            }
        }
        return ans;
    }
}
