#include <charconv>
#include <cstdlib>
#include <format>
#include <iostream>
#include <optional>
#include <string_view>

[[noreturn]] void usage() {
    std::cerr << "Usage: please input a non-negative integer\n";
    std::exit(1);
}

static constexpr std::string_view ws = " \t\n\r\f\v";
constexpr std::string_view trim(std::string_view s) {
    const auto start = s.find_first_not_of(ws);
    if (start == std::string_view::npos) return "";
    s.remove_prefix(start);

    const auto end = s.find_last_not_of(ws);
    s.remove_suffix(s.size() - 1 - end);
    return s;
}

std::optional<int> to_nonnegative_int(std::string_view s) {
    s = trim(s);
    int value{};
    auto [ptr, ec] = std::from_chars(s.data(), s.data() + s.size(), value);
    return (ec == std::errc{} && ptr == s.data() + s.size() && value >= 0)
               ? std::make_optional(value)
               : std::nullopt;
}

constexpr bool is_palindrome(int n) {
    int original = n;
    int reversed = 0;

    while (n > 0) {
        reversed = reversed * 10 + (n % 10);
        n /= 10;
    }

    return reversed == original;
}

int main(int argc, char* argv[]) {
    if (argc != 2) usage();

    if (auto n = to_nonnegative_int(argv[1]); n) {
        int original = *n;
        int reversed = 0;

        while (original > 0) {
            reversed = reversed * 10 + (original % 10);
            original /= 10;
        }

        std::cout << std::format("{}\n", reversed == *n);
    } else {
        usage();
    }
}