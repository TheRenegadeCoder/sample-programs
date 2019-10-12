//Major hearder file
#include <bits/stdc++.h>
/*or you can use the general files which are:
#include <iostream>
#include <cstring>
etc.
*/
using namespace std;
//Function to reverse the digits
int reverse(int num)
{
    int rev = 0;
    while (num > 0)
    {
        rev = rev * 10 + num % 10;
        num = num / 10;
    }
    return rev;
}

//Driver main function
int main()
{
    int num;
    cout << "Please enter the number to be reversed: ";
    cin >> num;
    cout << endl
         << "Reverse of " << num << " is: " << reverse(num);
    getchar();
    return 0;
}