#include <iostream>
#include <string>

void removeWhiteSpace(const std::string& input) {
    
    std::string result;
    //add loop and iterate through the strings 
    for(char c : input) {
    //add characters that aren't spaces
        if (c != ' ') {
    //print/update result
            result += c;
        }
    }
    //print out the result
    //return 0;
    std::cout << result << std::endl;
}

int main() {
    //added example string
    std::string noSpace = "RemoveAllWhiteSpace";
    std::string leadSpace = " RemoveAllWhiteSpace";

    removeWhiteSpace(noSpace);
    removeWhiteSpace(leadSpace);
    
    return 0;
} 
