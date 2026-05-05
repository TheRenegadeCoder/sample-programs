#include <algorithm>
#include <cctype>
#include <iostream>
#include <string_view>

[[noreturn]] void usage() {
    std::cerr << "Usage: please provide a string\n";
    std::exit(1);
}

int main(int argc, char* argv[]) {
    if (argc != 2) usage();

    std::string_view input = argv[1];
    if (input.empty()) usage();

    auto is_space = [](unsigned char c) { return std::isspace(c) != 0; };

    size_t best = 0;
    size_t cur = 0;

    for (unsigned char c : input) {
        if (is_space(c)) {
            best = std::max(best, cur);
            cur = 0;
        } else {
            ++cur;
        }
    }

    std::cout << std::max(best, cur) << '\n';
}