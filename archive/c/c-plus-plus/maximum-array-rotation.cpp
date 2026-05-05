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
    std::cerr
        << R"(Usage: please provide a list of integers (e.g. "8, 3, 1, 2"))"
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

int main(int argc, char* argv[]) {
    if (argc != 2) usage();

    std::string_view input = argv[1];
    if (input.empty()) usage();

    const auto vec_opt = parse_vec(input);
    if (const auto vec = *vec_opt; !vec_opt)
        usage();
    else {
        const int n = static_cast<int>(vec.size());
        long long sum = 0;
        long long cur = 0;

        for (int i = 0; i < n; ++i) {
            sum += vec[i];
            cur += static_cast<long long>(i) * vec[i];
        }

        long long best = cur;

        for (int k = 1; k < n; ++k) {
            const long long moved = vec[n - k];

            cur += sum - static_cast<long long>(n) * moved;
            best = std::max(best, cur);
        }

        std::cout << best << '\n';
    }
}