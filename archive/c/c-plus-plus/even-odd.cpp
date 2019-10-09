#include <iostream>
#include <cstring> 
using namespace std;

void even_odd(int number){
    if ((number % 2) == 0)
    {
        cout << "Even" << endl;
    }
    else
    {
        cout << "Odd" << endl;
    }
}

int main(int argc, char *argv[]){
    if (argc == 1 || argv[1][0] == '\0' || (atoi(argv[1]) == 0 && strcmp(argv[1], "0") != 0))//(argv[1] != 0 && atoi(argv[1]) == 0))//|| (argv[1] != 0 && atoi(argv[1]) == 0))//(argc == 1 || &argv[1][0] == NULL) //|| (stoi(argv[1]) == 0 || &atoi(argv[1] == NULL))
    {
        cout << "Usage: please input a number" << endl;
    }
    else {
        int number = atoi(argv[1]);
        even_odd(number);
    }
    return 0;
}