#include <algorithm>
#include <cctype>
#include <iostream>
#include <string_view>

[[noreturn]] void usage() {
    std::cerr << "Usage: please provide a string to encrypt\n";
    std::exit(1);
}

constexpr char rot13_char(char c) {
    if (c >= 'a' && c <= 'z') {
        return static_cast<char>('a' + (c - 'a' + 13) % 26);
    }
    if (c >= 'A' && c <= 'Z') {
        return static_cast<char>('A' + (c - 'A' + 13) % 26);
    }
    return c;
}

int main(int argc, char* argv[]) {
    if (argc != 2 || std::string_view(argv[1]).empty()) usage();

    std::string s = argv[1];
    std::ranges::transform(s, s.begin(), rot13_char);
    std::cout << s << '\n';
}