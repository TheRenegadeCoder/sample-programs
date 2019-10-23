#include <iostream>
#include <bits/stdc++.h>
 
using namespace std;

// A function to Swap two values provided
void swap(int *x,int *y){
	int t=*x;
	*x=*y;
	*y=t;
}

int main(int argc,char* argv[]){
	/*
		Condition to check for No String as Input
	*/
	if(argc<2){
		cout<<"Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""<<endl;
		exit(0);
	}

	vector<int> v;
	string s=argv[1];
	
	/*
		Conditon to check if given input has more than 2 integers and doesnot contain any spaces
	*/
	if(s.size()<4 || s.find(" ")!=string::npos){
		cout<<"Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""<<endl;
		exit(0);
	}

	/*
		Loop to convert numbers in string to integers
	*/
	for(int i=0;i<s.size();i++){
		if(s[i]!=','){
			v.push_back((int)(s[i]-'0'));
		}
	}

	int n=v.size();
	int min_idx;

	/*
		Loop to iterate all values in array
	*/
	for(int i=0;i<n-1;i++){
		min_idx=i;
		for(int j=i+1;j<n;j++){
			if(v[j]<v[min_idx]){
				min_idx=j;
			}
		}
		//swapping of ith value with current min_idx value
		swap(v[min_idx],v[i]);
	}

	for(int i=0;i<n;i++){
		cout<<v[i]<<" ";
	}
}
