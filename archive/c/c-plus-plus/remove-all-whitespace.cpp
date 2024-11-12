#include <iostream>
#include <string>
#include <cctype>  // for std::isspace


int main(int argc, char* argv[]) {

    // Check if given string passed
    if (argc < 2) {
        std::cout << "Usage: please provide a string" << std::endl;
        return 1; // Return error code if no string is given
    }

    // Get the string passed 
    std::string input = argv[1]; 
    std::string result;

    // Check if input string is empty
    if (input.empty()) {
        std::cout << "Usage: please provide a string" << std::endl;
        return 1; // Exit error code if the string is empty
    } 

    for(char c : input) {
        // If the character is not a whitespace character, add it to result     
        if (!std::isspace(static_cast<unsigned char>(c))) {
            result += c;
        }
    }
    //print out the result (string should have no spaces)
    std::cout << result << std::endl;
   
    return 0;
} 
