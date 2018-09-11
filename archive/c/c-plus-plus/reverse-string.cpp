#include <iostream>
#include <string>

int main()
{
    std::string s;
    std::getline(std::cin, s);

    std::cout << s.reserve() << "\n"; // That easy in C++ to reverse a string
}