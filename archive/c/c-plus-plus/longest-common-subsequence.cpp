#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
using namespace std;

vector<string> splitStrings(string str)
{
	string word = "";
	char dl = ',';
	int num = 0;

	str = str + dl;
	int l = str.size();

	vector<string> substr_list;

	for (int i = 0; i < l; i++)
	{
		if (str[i] != dl)
			word = word + str[i];
		else
		{
			if ((int)word.size() != 0)
				substr_list.push_back(word);

			word = "";
		}
	}
	return substr_list;
}

void longest_common_subsequence(vector<string> arr1, vector<string> arr2)
{
	int m = arr1.size();
	int n = arr2.size();
	int table[m + 1][n + 1];

	for (int row = 0; row <= m; row++)
	{
		for (int col = 0; col <= n; col++)
		{

			if (row == 0 || col == 0)
			{
				table[row][col] = 0;
			}
			else if (arr1[row - 1] == arr2[col - 1])
			{
				table[row][col] = 1 + table[row - 1][col - 1];
			}
			else
			{
				table[row][col] = max(table[row][col - 1], table[row - 1][col]);
			}
		}
	}

	vector<string> array_of_lcs;

	int i = m, j = n;
	while (i > 0 && j > 0)
	{
		if (arr1.at(i - 1) == arr2.at(j - 1))
		{
			array_of_lcs.insert(array_of_lcs.begin(), arr2[j - 1]);
			i--;
			j--;
		}
		else
		{
			if (table[i - 1][j] > table[i][j - 1])
			{
				i--;
			}
			else
			{
				j--;
			}
		}
	}

	for (int i = 0; i < array_of_lcs.size() - 1; i++)
	{
		cout << array_of_lcs[i] << ",";
	}
	cout << array_of_lcs[array_of_lcs.size() - 1] << endl;
}

int main(int argc, char *argv[])
{
	if (!(argc > 2 && std::string(argv[1]) != "" && std::string(argv[2]) != ""))
	{
		cout << "Usage: please provide two lists in the format \"1, 2, 3, 4, 5\"" << endl;
		return 1;
	}

	string input1 = argv[1];
	vector<string> arr1 = splitStrings(input1);

	string input2 = argv[2];
	vector<string> arr2 = splitStrings(input2);

	longest_common_subsequence(arr1, arr2);
	return 0;
}
