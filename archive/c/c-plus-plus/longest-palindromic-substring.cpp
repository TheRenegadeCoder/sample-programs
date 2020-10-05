#include <bits/stdc++.h> 
using namespace std; 

// Function to print str[low..high]
void printSubStr(char* str, int low, int high) 
{ 
	for (int i = low; i <= high; ++i) 
		cout << str[i]; 
} 

// Function that finds longest palindrome
int longestPalindrome(char* str) 
{ 
	int maxLength = 1; 
	int start = 0; 
	int len = strlen(str); 
	int low, high; 

	for (int i = 1; i < len; ++i) { 

        // finding longest even length palindrome
		low = i - 1; 
		high = i; 
		while (low >= 0 && high < len 
			&& str[low] == str[high]) { 
			if (high - low + 1 > maxLength) { 
				start = low; 
				maxLength = high - low + 1; 
			} 
			--low; 
			++high; 
		} 

        // finding longest odd length palindrome
		low = i - 1; 
		high = i + 1; 
		while (low >= 0 && high < len 
			&& str[low] == str[high]) { 
			if (high - low + 1 > maxLength) { 
				start = low; 
				maxLength = high - low + 1; 
			} 
			--low; 
			++high; 
		} 
	} 

	cout << "Longest palindrome substring is: "; 
	printSubStr(str, start, start + maxLength - 1); 

	return maxLength; 
} 

int main() 
{ 
	char str[] = "paapaapap"; 
	cout << "\nLength is: "
		<< longestPalindrome(str) 
		<< endl; 
	return 0; 
} 