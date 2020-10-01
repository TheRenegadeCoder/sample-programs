#include <iostream>

using namespace std;

int is_prime(int n){
    int flag = 1;
    for (int j = 2; j < n/2; j++)
    {
        if((n%j) == 0){
            return flag-1;
        }
    }
    return flag;
}

void goldbach(int n){
    int i = 2;

    for (int j = n-i; j > 2; j--)
    {
        if(is_prime(i) == 1 && is_prime(j) == 1)
        {
            cout << i << " + " << j << " = " << n;
            break;
        }
        i++;
    }
}

int main() {
    int n{ };
    int num1{ }, num2{ };
    cout << "Enter the number to check: ";
    cin >> n;
    goldbach(n);
}
