#include <charconv>
#include <format>
#include <iostream>
#include <optional>
#include <ranges>
#include <string_view>

namespace views = std::views;

[[noreturn]] void usage() {
    std::cerr
        << "Usage: please input the count of fibonacci numbers to output\n";
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

auto fibonacci_sequence() {
    return views::iota(0) | views::transform([a = 1LL, b = 1LL](auto) mutable {
               auto out = a;
               auto next = a + b;
               a = b;
               b = next;
               return out;
           });
}

int main(int argc, char* argv[]) {
    if (argc < 2) usage();

    if (auto n_opt = to_int(argv[1]); !n_opt || *n_opt < 0) {
        usage();
    } else {
        const int n = *n_opt;

        int index = 1;
        for (const auto value : fibonacci_sequence() | views::take(n)) {
            std::cout << std::format("{}: {}\n", index++, value);
        }
    }
}
