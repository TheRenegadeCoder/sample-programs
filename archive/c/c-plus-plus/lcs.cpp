#include<iostream>
#include<algorithm>
#include<vector>
#include<string>
using namespace std;

//The function to convert the input strings into the required array, by using delimiter.
vector<string> splitStrings(string str) 
{   
	string word = ""; 
    	char dl=',';
	int num = 0;                                 // to count the number of split strings 
	 
    	str = str + dl;                             // adding delimiter character at the end of str
    	int l = str.size();                         // length of 'str' 
	 
	// traversing 'str' from left to right 
	vector<string> substr_list; 
	
	for (int i = 0; i < l; i++) { 
	if (str[i] != dl)                       // if str[i] is not equal to the delimiter
		word = word + str[i];               // character then accumulate it to 'word'                          
	else { 
            	if ((int)word.size() != 0)                    // if 'word' is not an empty string, 
			substr_list.push_back(word);              // then add this to the array 
			                                                // 'substr_list[]' 
			// reset 'word' 
			word = "";
		} 
	}  
	return substr_list;                               // return the splitted strings 
}



//Main logic code for longest common subsequence.
void longest_common_subsequence(vector<string> arr1, vector<string> arr2){
    	int m = arr1.size();
    	int n = arr2.size();
    	int table[m + 1][n + 1];

    	for(int row = 0; row <= m; row++){
        	for(int col=  0; col <= n; col++){

            	if(row == 0 || col == 0){
                	table[row][col] = 0;
            	}
            	else if(arr1[row - 1] == arr2[col - 1]){
                	table[row][col] = 1 + table[row - 1][col - 1];
            	}
            	else{
                	table[row][col] = max(table[row][col - 1], table[row - 1][col]);
            	}
        	}
    	}
    
    	//this will be the vector to store the lcs.
    	vector<string> array_of_lcs;
    
    	int i = m, j = n;
    	while(i > 0 && j > 0){
        	if(arr1.at(i - 1) == arr2.at(j - 1)){
            	array_of_lcs.insert(array_of_lcs.begin(),arr2[j-1]);
            	i--;
            	j--;
        	}
        	else{
            		if(table[i - 1][j] > table[i][j - 1]){
                		i--;
            		}
            		else{
                		j--;
            		}
        	}
    	} 

    	for(int i=0;i<array_of_lcs.size()-1;i++){               //printing the lcs.
        	cout<<array_of_lcs[i]<<",";
    	}
	cout<<array_of_lcs[array_of_lcs.size()-1]<<endl;         //printing the last element of lcs.

}


//Driver code.
int main(int argc,char *argv[]) 
{   
    	//In case there is no input, empty input or only single input.
    	if (!(argc> 2 && std::string(argv[1]) != "" && std:: string(argv[2])!=""))                  
    	{
        	cout << "Usage: please provide two lists in the format \"1, 2, 3, 4, 5\"" << endl;
        	return 1;
    	}


    	string input1=argv[1];
    	vector<string> arr1=splitStrings(input1);      
    
    	string input2=argv[2];
    	vector<string> arr2=splitStrings(input2);


    	longest_common_subsequence(arr1,arr2);
		return 0; 
} 
