#include <algorithm>
#include <charconv>
#include <cstdlib>
#include <iostream>
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
    s = trim(s);
    int value{};
    auto [ptr, ec] = std::from_chars(s.data(), s.data() + s.size(), value);
    return (ec == std::errc{} && ptr == s.data() + s.size())
               ? std::make_optional(value)
               : std::nullopt;
}

template <ranges::random_access_range R>
    requires std::sortable<ranges::iterator_t<R>>
void insertion_sort(R&& r) {
    auto first = ranges::begin(r);
    auto last = ranges::end(r);

    for (auto it = first; it != last; ++it) {
        auto pos = std::upper_bound(first, it, *it);
        std::rotate(pos, it, std::next(it));
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) usage();

    const std::string_view input{argv[1]};
    auto ints_view = input | views::split(',') |
                     views::transform([](auto&& rng) {
                         return std::string_view(rng.begin(), rng.end());
                     }) |
                     views::transform(to_int) |
                     views::filter([](auto&& opt) { return opt.has_value(); }) |
                     views::transform([](auto&& opt) { return *opt; });

    std::vector<int> numbers;
    ranges::copy(ints_view, std::back_inserter(numbers));

    if (numbers.size() < 2) usage();

    insertion_sort(numbers);

    for (const char* sep = ""; int val : numbers) {
        std::cout << std::exchange(sep, ", ") << val;
    }
    std::cout << "\n";
}
