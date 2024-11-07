#include <iostream>
#include <string>
#include <cctype>  // for std::isspace


int main(int argc, char* argv[]) {

    
    if (input.empty()) {
        std::cout << "Usage: please provide a string" << std::endl;
        return; 
    }

    std::string result;
    //add loop and iterate through the strings 
    for(char c : input) {
    //add characters that aren't spaces
    // If the character is not a whitespace character, add it to result 
    // std::isspace -> if given character is a whitespace chara
    
        if (!std::isspace(static_cast<unsigned char>(c))) {
            result += c;
        }
    }
    //print out the result
    //return 0;
    std::cout << result << std::endl;
   
    return 0;
} 
