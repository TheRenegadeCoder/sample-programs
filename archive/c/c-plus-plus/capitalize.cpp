#include <cctype>
#include <format>
#include <iostream>
#include <string_view>

[[noreturn]] void usage() {
    std::cerr << "Usage: please provide a string\n";
    std::exit(1);
}

int main(int argc, char* argv[]) {
    if (argc < 2) usage();

    std::string_view input{argv[1]};
    if (input.empty()) usage();

    char head = static_cast<char>(
        std::toupper(static_cast<unsigned char>(input.front())));

    std::string_view tail = input.substr(1);

    std::cout << std::format("{}{}\n", head, tail);
    return 0;
}