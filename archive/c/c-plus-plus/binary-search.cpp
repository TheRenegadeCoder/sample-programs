#include <algorithm>
#include <charconv>
#include <cstdlib>
#include <format>
#include <iostream>
#include <memory>
#include <optional>
#include <ranges>
#include <string_view>
#include <vector>

namespace ranges = std::ranges;
namespace views = std::views;

[[noreturn]] void usage() {
    std::cerr
        << R"(Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11"))"
        << '\n';
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
    if (argc != 3) usage();

    const auto target = to_int(argv[2]);
    if (!target) usage();

    const std::string_view input{argv[1]};
    auto ints_view = input | views::split(',') |
                     views::transform([](auto&& rng) {
                         return std::string_view(rng.begin(), rng.end());
                     }) |
                     views::transform(to_int) |
                     views::filter([](auto&& opt) { return opt.has_value(); }) |
                     views::transform([](auto&& opt) { return *opt; });

    std::vector<int> haystack;
    ranges::copy(ints_view, std::back_inserter(haystack));

    if (haystack.empty() || !ranges::is_sorted(haystack)) usage();

    const bool found = ranges::binary_search(haystack, *target);
    std::cout << std::format("{}\n", found);

    return 0;
}