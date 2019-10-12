#include <iostream>
#include <cstring>

int main(int argc, const char *argv[])
{
    if (argc < 2) { //If there is less than 2 arguments, no string was passed
        std::cout << "Error: You must imput a string!";
        return 1;
    }
    if (!(*argv[1] > 0x61 && *argv[1] < 0x7A)) { //If the first character is not a lowercase letter, return an error
        std::cout << "Error: Fist character of string must be a lowercase letter!";
    }

    for (int i = 1; i < argc; i++) {
        if (i == 1) {                                              //If it is the first letter of the entire string
            for (int j = 0; j < (int) std::strlen(argv[1]); j++) { //Then iterate through the first word passed
                if (j == 0)                                        //If it is the first letter of the first word
                    std::cout << (char) ((*argv[1]) - 0x20);       //Print out the current characters value - 0x20 to get the uppercase
                else
                    std::cout << *(argv[1] + sizeof(char)*j);      //Otherwise just print out the character
            }
        } else
            std::cout << argv[i];                                  //If not the first string, then just print out the current word

        if (i < argc - 1)                                          //Make sure to not output an extra space at the end
            std::cout << " ";
    }
}
