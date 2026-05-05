#include <algorithm>
#include <iostream>
#include <ranges>
#include <string_view>

[[noreturn]] void usage() {
    std::cerr << "Usage: please provide a string of roman numerals\n";
    std::exit(1);
}

[[noreturn]] void error() {
    std::cerr << "Error: invalid string of roman numerals\n";
    std::exit(1);
}

constexpr int value(char c) {
    switch (c) {
        case 'I':
            return 1;
        case 'V':
            return 5;
        case 'X':
            return 10;
        case 'L':
            return 50;
        case 'C':
            return 100;
        case 'D':
            return 500;
        case 'M':
            return 1000;
        default:
            return -1;
    }
}

constexpr bool is_valid(char c) { return value(c) != -1; }

int main(int argc, char* argv[]) {
    if (argc < 2) usage();

    std::string_view s = argv[1];

    if (s.empty()) {
        std::cout << 0 << '\n';
        return 0;
    }

    if (!std::ranges::all_of(s, is_valid)) error();

    int result = 0;

    for (std::size_t i = 0; i < s.size(); ++i) {
        int curr = value(s[i]);

        if (i + 1 < s.size()) {
            int next = value(s[i + 1]);

            if (curr < next) {
                result += next - curr;
                ++i;
                continue;
            }
        }

        result += curr;
    }

    std::cout << result << '\n';
}