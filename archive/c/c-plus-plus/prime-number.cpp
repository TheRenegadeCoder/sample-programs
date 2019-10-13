#include<iostream>
#include<stdlib.h>
#include<string.h>

using namespace std;

int main(int argc, char **argv)
{
    if (argc == 1 || argv[1][0] == '\0' || (atoi(argv[1]) == 0 && strcmp(argv[1], "0") != 0)) {
        cout<<"Usage: please input a number\n";
    } 
    else {
        int input = atoi(argv[1]);
        for(int i = 2; i < input; ++i){
            if(input % i == 0){
                cout<<"Not Prime\n";
                return 0;
            }
        }
        cout<<"Prime\n";
    }

    return 0;
}
