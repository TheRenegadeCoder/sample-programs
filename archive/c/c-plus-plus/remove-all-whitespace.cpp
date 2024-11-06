#include <iostream>
#include <string>

int main() {
    //added example string
    std::string sentence = "This is a sentence with spaces.";
    std::string result;

    //add loop and iterate through the strings 
    for(char c : sentence) {
    //add characters that aren't spaces
        if (c != ' ') {
    //print/update result
            result += c;
        }
    }

    //print out the result
    //return 0;
    std::cout << "Result: " << result << std::endl;
    return 0;
}
