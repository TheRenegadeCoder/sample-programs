#include <iostream>
#include <string>

int main() {
    //added example string
    std::string noSpace = "RemoveAllWhiteSpace";
    std::string leadSpace = " RemoveAllWhiteSpace";
} 

void removeWhiteSpace() {
    
    std::string result;
    //add loop and iterate through the strings 
    for(char c : noSpace + leadSpace) {
    //add characters that aren't spaces
        if (c != ' ') {
    //print/update result
            result += c;
        }
    }

    //print out the result
    //return 0;
    std::cout << result << std::endl;
    return 0;
}
