import java.util.*;

public class LinearSearch {

    public static void main(String[] args) {
        try {
            ArrayList<Integer> listOfNumbers = new ArrayList<>();
            Integer keyToSearch = Integer.parseInt(args[1]);
            String[] NumberArray = args[0].split(",");
            for(String Number: NumberArray) {
                listOfNumbers.add(Integer.parseInt(Number.trim()));
            }
            if(listOfNumbers.size() >= 2){
                StringBuilder output = new StringBuilder();
                Boolean searched = linearSearch(listOfNumbers, keyToSearch);
                System.out.println(searched);
            }else{
                System.out.println("Usage: please provide a list of at least two integers to search in the format \"1, 2, 3, 4, 5\"");
            }
        }
        catch(Exception e) {
            System.out.println("Usage: please provide a list of at least two integers to search in the format \"1, 2, 3, 4, 5\"");
        }
    }

    private static Boolean linearSearch(ArrayList<Integer> list, Integer keyToSearch) {
        Boolean ans = false;
        for (Integer number : list) {
            if(number == keyToSearch) {
                ans = true;
                break;
            }
        }
        return ans;
    }
}
