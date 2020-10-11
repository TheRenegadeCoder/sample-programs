import java.util.*;
public class Lcs{

    //A function to get the input string from the command line and form a array-list of elements from it.
    static ArrayList<String> split_strings(String str)         
    {
        String word = ""; 
        char dl=',';
	     
        str = str + dl;                             // adding delimiter character at the end of 'str'. 
                                                    
        // traversing 'str' from left to right 
	    ArrayList<String> substr_list=new ArrayList<>(); 
	    for (int i = 0; i < str.length(); i++) { 

		    if (str.charAt(i) != dl)                       // if str[i] is not equal to the delimiter
			    word = word + str.charAt(i);               // character then accumulate it to 'word'                          
		    else { 
                if ((int)word.length() != 0)                    // if 'word' is not an empty string, 
			        substr_list.add(word);              // then add this 'word' to the array 
			                                                    // 'substr_list[]' 
			    // reset 'word' 
			    word = "";
		    } 
	    } 

	    // return the splitted strings 
	    return substr_list; 
    }


    //The main logic function to give the Longest-common-sub-sequence from two array-list.
    static void longest_common_subsequence(ArrayList<String> arr1, ArrayList<String> arr2) {

        int[][] array = new int[arr1.size() + 1][arr2.size() + 1];                   //array for the Dynamic solution.

        for(int i = 0; i < array.length; i++) {
            for(int j= 0; j < array[0].length; j++) {

                if(i == 0 || j == 0) {
                    array[i][j] = 0;
                }
                else if(arr1.get(i - 1).equals(arr2.get(j - 1))) {
                    array[i][j] = 1 + array[i - 1][j - 1];
                }
                else {
                    array[i][j] = Math.max(array[i - 1][j], array[i][j - 1]);
                }
            }
        }


        ArrayList<String> lcs=new ArrayList<>();                             //this array-list will contain the lcs.
        int x= array.length-1;
        int y= array[0].length-1;

        while(x>0 && y>0) {

            if(arr1.get(x-1).equals(arr2.get(y-1))) {
                lcs.add(0,arr1.get(x-1));
                x--;
                y--;
            }
            else {
                if(array[x-1][y]>array[x][y-1])
                    x--;
                else
                    y--;
            }
        }

        //Printing the longest common subsequence.
        for(int element = 0; element < lcs.size()-1; element++) {
            System.out.print(lcs.get(element) + ",");
        }
        System.out.println(lcs.get(lcs.size()-1));              //printing the last element of the lcs.

        //The last element of the lcs is printed seprately (after the loop), to prevent the "," printing after it.
    }


    //Driver code.d
    public static void main(String args[]) {

        if(args.length <2 || args[0] == "" || args[1] == "") {
            System.out.println("Usage: please provide two lists in the format \"1, 2, 3, 4, 5\"");
            return ;
        }

        ArrayList<String> arr1 = split_strings(args[0]);
        ArrayList<String> arr2 = split_strings(args[1]);
        
        longest_common_subsequence(arr1, arr2);
    }
}
