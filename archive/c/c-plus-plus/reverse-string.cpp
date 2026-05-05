#include <algorithm>
#include <iostream>
#include <string>
#include <string_view>

int main(int argc, char* argv[]) {
    if (argc < 2 || std::string_view(argv[1]).empty()) {
        return 0;
    }

    std::string s = argv[1];
    std::ranges::reverse(s);

    std::cout << s << '\n';
}