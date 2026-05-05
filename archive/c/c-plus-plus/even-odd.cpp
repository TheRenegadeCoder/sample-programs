#include <charconv>
#include <iostream>
#include <optional>
#include <string_view>

[[noreturn]] void usage() {
    std::cout << "Usage: please input a number\n";
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

    const auto input_opt = to_int(argv[1]);
    if (!input_opt) usage();

    const int input = *input_opt;

    std::cout << ((input % 2 == 0) ? "Even" : "Odd") << '\n';
}