#include <array>
#include <format>
#include <iostream>
#include <string_view>

[[noreturn]] void usage() {
    std::cout << "Usage: please provide a string\n";
    std::exit(1);
}

int main(int argc, char* argv[]) {
    if (argc != 2) usage();

    std::string_view input{argv[1]};
    if (input.empty()) usage();

    std::array<std::size_t, 256> counts{};

    for (const auto c : input) {
        counts[c]++;
    }

    bool any_duplicates = false;

    for (const auto c : input) {
        if (counts[c] > 1) {
            std::cout << std::format("{}: {}\n", c, counts[c]);
            counts[c] = 0;
            any_duplicates = true;
        }
    }

    if (!any_duplicates) {
        std::cout << "No duplicate characters\n";
    }
}