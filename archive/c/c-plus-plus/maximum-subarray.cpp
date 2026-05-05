#include <algorithm>
#include <charconv>
#include <cstdlib>
#include <iostream>
#include <optional>
#include <ranges>
#include <string_view>
#include <vector>

namespace ranges = std::ranges;
namespace views = std::views;

[[noreturn]] void usage() {
    std::cout << "Usage: Please provide a list of integers in the format: \"1, "
                 "2, 3, 4, 5\"\n";
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
    int value{};
    auto [ptr, ec] = std::from_chars(s.data(), s.data() + s.size(), value);
    return (ec == std::errc{} && ptr == s.data() + s.size())
               ? std::make_optional(value)
               : std::nullopt;
}

std::optional<std::vector<int>> parse_vec(std::string_view s) {
    auto pipe = s | views::split(',') | views::transform([](auto&& r) {
                    return std::string_view{
                        std::addressof(*ranges::begin(r)),
                        static_cast<std::size_t>(ranges::distance(r))};
                }) |
                views::transform(trim) | views::transform(to_int);

    std::vector<int> out;
    for (auto&& opt : pipe) {
        if (!opt) return std::nullopt;
        out.push_back(*opt);
    }
    return out.empty() ? std::nullopt : std::make_optional(out);
}

int max_subarray_sum(const std::vector<int>& arr) {
    int best = arr[0];
    int current = 0;

    for (int x : arr) {
        current = std::max(x, current + x);
        best = std::max(best, current);
    }

    return best;
}

int main(int argc, char* argv[]) {
    if (argc < 2) usage();

    if (auto vec = parse_vec(argv[1]); vec)
        std::cout << max_subarray_sum(*vec) << '\n';
    else
        usage();
}