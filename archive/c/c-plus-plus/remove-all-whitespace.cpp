#include <algorithm>
#include <cctype>
#include <iostream>
#include <ranges>
#include <string>
#include <string_view>

[[noreturn]] void usage() {
    std::cerr << "Usage: please provide a string\n";
    std::exit(1);
}

int main(int argc, char* argv[]) {
    if (argc < 2) usage();

    std::string_view input = argv[1];
    if (input.empty()) usage();

    auto is_not_space = [](unsigned char c) { return !std::isspace(c); };
    auto filtered = input | std::views::filter(is_not_space);

    std::string result;
    std::ranges::copy(filtered, std::back_inserter(result));

    std::cout << result << '\n';
}