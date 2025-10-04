#include <iostream>
#include <string>

using namespace std;

void rot13(string& str) {
    for (char& c : str) {
        if (('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z')) {
            if (('a' <= c && c <= 'm') || ('A' <= c && c <= 'M')) {
                c += 13;
            } else {
                c -= 13;
            }
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc == 2 && string(argv[1]).size() != 0) {
        string inputString(argv[1]);
        rot13(inputString);
        cout << inputString << endl;
    } else {
        cout << "Usage: please provide a string to encrypt" << endl;
    }

    return 0;
}
