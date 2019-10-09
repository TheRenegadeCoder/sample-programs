#include<iostream>
#include<stdlib.h>
#include<string.h>

using namespace std;

int main(int argc, char **argv)
{
    if (argc == 1 || argv[1][0] == '\0' || (atoi(argv[1]) == 0 && strcmp(argv[1], "0") != 0)) {
        cout<<"Usage: please input a number\n";
    } else {
        int input = atoi(argv[1]);
        if (input % 2 == 0) {
            cout<<"Even\n";
        }
        else {
            cout<<"Odd\n";
        }
    }

    return 0;
}
