#include <iostream>
#include <string.h>
#include <stdlib.h>

using namespace std;

void palindromic_number(int number)
{
    int temp = number, no_of_digits = 0, reversed_number = 0;

    while (temp > 0)
    {
        reversed_number = (reversed_number * 10) + (temp % 10);
        temp = (int)(temp / 10);
        no_of_digits++;
    }
    if (no_of_digits < 2)
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

int is_int(char *number_string)
{
    if (number_string[0] > '9' || number_string[0] < '0')
        return (0);
    for (int counter = 0; number_string[counter]; counter++)
    {
        if (number_string[0] > '9' || number_string[0] < '0')
            return (0);
    }
    return (1);
}

int main(int argc, char **argv)
{
    if (argc != 2 || is_int(argv[1]) != 1)
    {
        cout << "Usage: please input a non-negative integer";
        return (1);
    }
    palindromic_number(atoi(argv[1]));
    return (0);
}
