#include <iostream>
#include <fstream>
#include <string>
#include <regex>

int main() {
    std::ifstream inputFile("input.cpp"); // Change "input.cpp" to your input file name
    std::ofstream outputFile("output.cpp"); // Change "output.cpp" to your output file name

    if (!inputFile) {
        std::cerr << "Error: Unable to open input file." << std::endl;
        return 1;
    }

    if (!outputFile) {
        std::cerr << "Error: Unable to open output file." << std::endl;
        return 1;
    }

    std::string line;
    bool inMultiLineComment = false;

    while (std::getline(inputFile, line)) {
        if (!inMultiLineComment) {
            // Remove single-line comments
            line = std::regex_replace(line, std::regex("//.*"), "");
            // Check for the start of a multi-line comment
            if (std::regex_search(line, std::regex("/\\*"))) {
                inMultiLineComment = true;
            }
        }

        if (inMultiLineComment) {
            // Check for the end of a multi-line comment
            if (std::regex_search(line, std::regex("\\*/"))) {
                inMultiLineComment = false;
                // Remove everything up to and including the end of the multi-line comment
                line = std::regex_replace(line, std::regex(".*\\*/"), "");
            } else {
                // Skip this line if still inside a multi-line comment
                continue;
            }
        }

        outputFile << line << std::endl;
    }

    inputFile.close();
    outputFile.close();

    std::cout << "Comments removed successfully. Output saved to 'output.cpp'." << std::endl;

    return 0;
}
