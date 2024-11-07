#include <iostream>
#include <string>

void removeWhitespace(const std::string& input) {
    
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
}

int main() {
    //added example string
    std::string noSpace = "RemoveAllWhitespace";
    std::string leadSpace = " RemoveAllWhitespace";
    std::string trailSpace = "RemoveAllWhitespace ";
    std::string innerSpace = "Remove All Whitespace";
    std::string tabs = "\tRemove\tAll\tWhitespace\t";
    std::string newsLines = "\nRemove\nAll\nWhitespace\n";
    std::string carriageReturns = "\rRemove\rAll\rWhitespace";

    removeWhitespace(noSpace); 
    removeWhitespace(leadSpace); 
    removeWhitespace(trailSpace);
    removeWhitespace(innerSpace);
    removeWhitespace(tabs);
    removeWhitespace(newsLines);
    removeWhitespace(carriageReturns);
    
    return 0;
} 
