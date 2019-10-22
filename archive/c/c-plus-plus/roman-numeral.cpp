#include <iostream>
#include <bits/stdc++.h>
 
using namespace std;

/*
	a function which returns false when a character belongs to Roman literals else returns true
*/
bool is_roman(char x){
	return !(x=='I' || x=='V' || x=='X' || x=='L' || x=='C' || x=='D' || x=='M');
}

/*
	Roman to Numerical convert function
*/
int main(int argc,char* argv[]){
	//condition to check null input
	if(argv[1]==NULL){
		cerr<<"Usage: please provide a string of roman numerals"<<endl;
		exit(0);
	}

	//storing the roman number in a string
	string s;
	s=argv[1];

	//checking each character for any invalid input
	for(char c:s){
		if(is_roman(c)){
			cerr<<"Error: invalid string of roman numerals"<<endl;
			exit(0);
		}
	}

	//map to store the values of Roman characters and their corresponding integer value
	map<char,int> value;
	value['I']=1;
	value['V']=5;
	value['X']=10;
	value['L']=50;
	value['C']=100;
	value['D']=500;
	value['M']=1000;

	//variable to store the value
	int num=0;

	for(int i=s.size()-1;i>=0;i--){
		//To handle cases like IV where it should be considered as 4
		if(value[s[i]]>value[s[i-1]] && i>0){
			num+=value[s[i]]-value[s[i-1]];
			i--;
		}else{
			num+=value[s[i]];
		}
	}

	cout<<num<<endl;
}
