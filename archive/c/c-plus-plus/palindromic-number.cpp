#include <iostream>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

using namespace std;

void palindromic_number(int number)
{
    int temp = number, reversed_number = 0;

    while (temp > 0)
    {
        reversed_number = (reversed_number * 10) + (temp % 10);
        temp = (int)(temp / 10);
    }
    if (number < 0)
    {
        cout << "Usage: please input a non-negative integer";
        exit(1);
    }
    else
    {
        if (reversed_number == number)
        {
            cout << "true";
        }
        else
        {
            cout << "false";
        }
    }
}

int is_int(char **argv)
{
    int j = 0;
    while (isdigit(argv[1][j]))
        ++j;

    if (strlen(argv[1]) != j || j == 0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

int main(int argc, char **argv)
{
    if (argc != 2 || is_int(argv))
    {
        cout << "Usage: please input a non-negative integer";
        return (1);
    }
    palindromic_number(atoi(argv[1]));
    return (0);
}
