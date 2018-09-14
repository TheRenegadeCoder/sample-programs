#include <iostream>
#include <string>
#include <algorithm>

int main()
{
    std::string s = "Some arbitrary text";
    std::reverse(s.begin(), s.end());

    std::cout << s << "\n";
}