#include <iostream>
#include <cstring>

int main(int argc, const char *argv[])
{
    if (argc < 2 || argv[1][0] == '\0') { //If there is less than 2 arguments, no string was passed
        std::cout << "Usage: please provide a string";
        return 1;
    }
    
    for (int j = 0; j < (int) std::strlen(argv[1]); j++) { 
        if (j == 0)                                        
            std::cout << (char) toupper(argv[1][j]);      
        else
            std::cout << *(argv[1] + sizeof(char)*j);      
    }
}
