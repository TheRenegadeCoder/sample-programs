#include <algorithm>
#include <charconv>
#include <concepts>
#include <iostream>
#include <optional>
#include <ranges>
#include <string_view>
#include <utility>
#include <vector>

namespace views = std::views;
namespace ranges = std::ranges;

[[noreturn]] void usage() {
    std::cerr
        << R"(Usage: please provide two lists in the format "1, 2, 3, 4, 5")"
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

template <typename T>
std::vector<T> find_lcs(const std::vector<T>& a, const std::vector<T>& b) {
    const std::size_t m = a.size();
    const std::size_t n = b.size();

    auto idx = [n](std::size_t i, std::size_t j) { return i * (n + 1) + j; };

    std::vector<int> dp((m + 1) * (n + 1), 0);

    for (std::size_t i = 1; i <= m; ++i) {
        for (std::size_t j = 1; j <= n; ++j) {
            if (a[i - 1] == b[j - 1])
                dp[idx(i, j)] = dp[idx(i - 1, j - 1)] + 1;
            else
                dp[idx(i, j)] = std::max(dp[idx(i - 1, j)], dp[idx(i, j - 1)]);
        }
    }

    std::vector<T> result;
    result.reserve(dp.back());

    std::size_t i = m, j = n;

    while (i > 0 && j > 0) {
        if (a[i - 1] == b[j - 1]) {
            result.push_back(a[i - 1]);
            --i;
            --j;
        } else if (dp[idx(i - 1, j)] > dp[idx(i, j - 1)]) {
            --i;
        } else {
            --j;
        }
    }

    ranges::reverse(result);
    return result;
}

int main(int argc, char* argv[]) {
    if (argc != 3) usage();

    const auto a = parse_vec(argv[1]);
    const auto b = parse_vec(argv[2]);
    if (!a || !b) usage();

    const auto result = find_lcs(*a, *b);

    for (const char* sep = ""; int val : result) {
        std::cout << std::exchange(sep, ", ") << val;
    }
    std::cout << "\n";
}