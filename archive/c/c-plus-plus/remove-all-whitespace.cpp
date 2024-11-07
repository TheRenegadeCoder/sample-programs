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
    std::string noSpace = "RemoveAllWhitespace";
    std::string leadSpace = " RemoveAllWhitespace";
    std::string trailSpace = "RemoveAllWhitespace ";
    std::string innerSpace = "Remove All Whitespace";

    removeWhiteSpace(noSpace); 
    removeWhiteSpace(leadSpace); 
    removeWhiteSpace(trailSpace);
    removeWhiteSpace(innerSpace);
    
    return 0;
} 
