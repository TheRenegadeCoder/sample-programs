#include <iostream>
#include <string>
#include <algorithm>

int main(int argc, char *argv[])
{
    if(argc < 2)
        return 0;
    
    std::string s = argv[1];
    std::reverse(s.begin(), s.end());

    std::cout << s << "\n";
}