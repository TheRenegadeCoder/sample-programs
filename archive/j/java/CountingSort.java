import java.util.*;

public class CountingSort {

    public static void main(String[] args) {
        try {
            ArrayList<Integer> listOfNumbers = new ArrayList<>();
            String[] NumberArray = args[0].split(",");
            for(String Number: NumberArray) {
                listOfNumbers.add(Integer.parseInt(Number.trim()));
            }
            if(listOfNumbers.size() >= 2){
                StringBuilder output = new StringBuilder();
                ArrayList<Integer> SortedList = sort(listOfNumbers);
                int count = 0;
                for(Integer Number: SortedList){
                    if(SortedList.indexOf(Number) == 0 && count == 0){
                        output.append(Number);
                        count++;
                    }else{
                        output.append(", ").append(Number);
                    }
                }
                System.out.println(output);
            }else{
                System.out.println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
            }
        }
        catch(Exception e) {
            System.out.println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"");
        }
    }

    private static ArrayList<Integer> sort(ArrayList<Integer> list){
        int[] countingArray = list.stream().mapToInt(i -> i).toArray();
        int max = Arrays.stream(countingArray).max().getAsInt();
        int min = Arrays.stream(countingArray).min().getAsInt();
        int range = max - min + 1; 
        int count[] = new int[range]; 
        int output[] = new int[countingArray.length]; 
        for (int index = 0; index < countingArray.length; index++) { 
            count[countingArray[index] - min]++; 
        } 
  
        for (int index = 1; index < count.length; index++) { 
            count[index] += count[index - 1]; 
        } 
  
        for (int index = countingArray.length - 1; index >= 0; index--) { 
            output[count[countingArray[index] - min] - 1] = countingArray[index]; 
            count[countingArray[index] - min]--; 
        }
        for (int i = 0; i < countingArray.length; i++) {
            countingArray[i] = output[i];
        }
        ArrayList<Integer> outputList = new ArrayList<Integer>(countingArray.length);
        for (int number : countingArray)
        {
            outputList.add(number);
        }return outputList;
    }
}
