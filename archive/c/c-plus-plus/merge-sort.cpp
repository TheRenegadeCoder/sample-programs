#include <iostream>
#include <bits/stdc++.h>
 
using namespace std;

//Function to handle errors
void handle_error(){
	cout<<"Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""<<endl;
	exit(0);
}

//Function to check whether inputs satisfy given constraints
int check(string s){
	int x1=0,x2=s.size()-1;

	//x1 gives first index position where integer occurs
	for(int i=0;i<s.size();i++){
		if(s[i]!=' '){
			x1=i;
			break;
		}
	}

	//x2 gives last index position where integer occurs
	for(int i=s.size()-1;i>=x1;i--){
		if(s[i]!=' '){
			x2=i;
			break;
		}
	}
	
	//if any space occurs between this substring then throw error
	for(int i=x1;i<=x2;i++){
		if(s[i]==' '){
			handle_error();
		}
	}

	return stoi(s);
}

//Function for converting string input into integer vector 
vector<int> convert(string s){
	/*
		Loop to convert numbers in string to integers
	*/
	vector<int> v;
	string num="";
	for(int i=0;i<s.size();i++){
		if((int)s[i]>=48 && (int)s[i]<=57 || s[i]==' '){
			num+=s[i];
		}else if(s[i]==','){
			v.push_back(check(num));
			num="";
		}else{
			handle_error();	
		}
	}


	if(num.size()>0){
		v.push_back(check(num));
	}
	
	return v;
}

//merge functions merges the halves and sorts the combined array 
void merge(int low,int mid,int high,vector<int> &v){
	//n1,n2 size of intervals of two halves
	int n1=mid-low+1;
	int n2=high-mid;

	//v1,v2 stores the halves independently in two different vectors
	vector<int> v1(n1),v2(n2);

	/*
		For loops for filling up the vectors
	*/
	for(int i=0;i<n1;i++){
		v1[i]=v[i+low];
	}

	for(int i=0;i<n2;i++){
		v2[i]=v[i+mid+1];
	}

	//j,k are index values for v1,v2 respectively
	//l is index for vector v
	int j=0,k=0;
	int l=low;

	//loop for comparing the values and changing the values in the vector v
	while(j<n1 && k<n2){
		if(v1[j]<v2[k]){
			v[l]=v1[j];
			j++;
		}else{
			v[l]=v2[k];
			k++;
		}
		l++;
	}

	//filling the vector with remaining vectors
	while(j<n1){
		v[l]=v1[j];
		j++;l++;
	}

	while(k<n2){
		v[l]=v2[k];
		k++;l++;
	}

}

//breaks the array at mid point and recursively calls the same fuction
void mergesort(int low,int high,vector<int> &v){
	/*
		mid gives value where to break the array
	*/
	if(low<high){
		int mid=(low+high)/2;
		mergesort(low,mid,v);
		mergesort(mid+1,high,v);
		merge(low,mid,high,v);
	}
}

int main(int argc,char* argv[]){
	/*
		Condition to check for No String as Input
	*/
	if(argc<2){
		handle_error();
	}

	vector<int> v=convert(argv[1]);

	/*
		Conditon to check if given input has more than 2 integers
	*/
	if(v.size()<2){
		cout<<"Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""<<endl;
		exit(0);
	}

	int n=v.size();
	int min_idx;

	//calling mergesort function
	mergesort(0,n-1,v);

	for(int i=0;i<n-1;i++){
		cout<<v[i]<<", ";
	}
	cout<<v[n-1];
}
