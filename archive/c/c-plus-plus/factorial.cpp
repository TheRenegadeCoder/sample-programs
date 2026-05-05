#include <charconv>
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

std::optional<int> to_int(std::string_view s) {
    s = trim(s);
    int value{};
    auto [ptr, ec] = std::from_chars(s.data(), s.data() + s.size(), value);
    return (ec == std::errc{} && ptr == s.data() + s.size())
               ? std::make_optional(value)
               : std::nullopt;
}

int main(int argc, char* argv[]) {
    if (argc != 2) usage();

    if (auto n = to_int(argv[1]); !n || *n < 0) {
        usage();
    } else {
        unsigned long long result = 1;
        for (int i = 2; i <= *n; ++i) {
            result *= i;
        }
        std::cout << result << '\n';
    }
}