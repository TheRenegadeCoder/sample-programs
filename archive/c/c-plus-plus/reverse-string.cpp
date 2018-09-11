#include <iostream>
#include <string>

int main()
{
    std::string s;
    std::getline(std::cin, s);

    s.reserve(); // That easy in C++ to reverse a string
    std::cout << s << "\n";
}