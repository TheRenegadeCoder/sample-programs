#include <iostream> 
#include <sstream> 
#include <string>
#include <vector>
using namespace std; 

void insertion_sort(string str, vector<int> arr) 
{ 
	stringstream ss;	 
	ss << str; 
	string temp; 
	int found; 
	while (!ss.eof()) 
	{ 
		ss >> temp; 
		if (stringstream(temp) >> found) 
		{
		    arr.push_back(found);
		}
		temp = ""; 
	} 
	
	int t,j;
    for(int i=1;i<arr.size();i++){
        t = arr[i];
        j = i-1;
        while(j >= 0 && t<=arr[j]){
            arr[j+1] = arr[j];
            j--;
        }
        arr[j+1] = t;
    }
    
    int i;  
    for (i = 0; i < arr.size(); i++)  
        cout << arr[i] << " ";  
    cout << endl;
} 

int main() 
{ 
	string str;
	vector<int>arr;
	getline (cin, str); 
	insertion_sort(str,arr); 
	return 0; 
} 