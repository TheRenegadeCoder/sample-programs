/*
 * Author: karthikeyan rathore
 * Binary Exponentiation Algorithm recursive approach
*/

#include<bits/stdc++.h>
using namespace std;

long long bin(long long  a , long long b){
	if(b == 0) return 1;
	
	long long res = bin(a , b/2);
	if( b % 2) {
		return res * res * a;
	}
	else return res * res;
}

int main(){
	long long a = 2 , b = 5;
	long long ans = bin(2 , 5);
	cout << ans;
}

		
/*
 * INPUT : a = 2 , b = 5 ....(2 ^ 5)
 * OUTPUT : 32
*/









