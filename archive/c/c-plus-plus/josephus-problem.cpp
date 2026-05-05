#include <charconv>
#include <iostream>
#include <optional>
#include <string_view>

[[noreturn]] void usage() {
    std::cerr << "Usage: please input the total number of people and number of "
                 "people to skip.\n";
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
    int value{};
    auto [ptr, ec] = std::from_chars(s.data(), s.data() + s.size(), value);
    return (ec == std::errc{} && ptr == s.data() + s.size() && value > 0)
               ? std::make_optional(value)
               : std::nullopt;
}

int josephus(int n, int k) {
    int survivor = 0;
    for (int i = 1; i <= n; ++i) {
        survivor = (survivor + k) % i;
    }
    return survivor + 1;
}

int main(int argc, char* argv[]) {
    if (argc != 3) usage();

    const auto n = to_nonnegative_int(argv[1]);
    const auto k = to_nonnegative_int(argv[2]);

    if (!n || !k) usage();

    std::cout << josephus(*n, *k) << '\n';
}