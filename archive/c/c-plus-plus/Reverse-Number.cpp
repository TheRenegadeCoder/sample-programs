#include <iostream>
using namespace std;

int main() {
    int n, reversed_Number = 0, remainder;

    cout << "Enter an integer: ";
    cin >> n;

    while(n != 0) {
        remainder = n%10;
        reversed_Number = reversed_Number*10 + remainder;
        n /= 10;
    }

    cout << "Reversed Number = " << reversed_Number;

    return 0;
}
