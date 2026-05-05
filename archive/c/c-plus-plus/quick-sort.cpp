#include <algorithm>
#include <charconv>
#include <cstdlib>
#include <iostream>
#include <iterator>
#include <optional>
#include <ranges>
#include <string_view>
#include <utility>
#include <vector>

namespace ranges = std::ranges;
namespace views = std::views;

[[noreturn]] void usage() {
    std::cerr
        << R"(Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5")"
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
    return out.size() < 2 ? std::nullopt : std::make_optional(out);
}

template <ranges::random_access_range R>
    requires std::sortable<ranges::iterator_t<R>>
void quick_sort(R&& r) {
    auto first = ranges::begin(r);
    auto last = ranges::end(r);

    auto n = std::distance(first, last);
    if (n <= 1) return;

    auto pivot = first + n / 2;

    std::nth_element(first, pivot, last);

    quick_sort(ranges::subrange(first, pivot));
    quick_sort(ranges::subrange(std::next(pivot), last));
}

int main(int argc, char* argv[]) {
    if (argc != 2) usage();

    auto vec = parse_vec(argv[1]);
    if (!vec) usage();

    quick_sort(*vec);

    for (const char* sep = ""; int val : *vec) {
        std::cout << std::exchange(sep, ", ") << val;
    }
    std::cout << "\n";
}
