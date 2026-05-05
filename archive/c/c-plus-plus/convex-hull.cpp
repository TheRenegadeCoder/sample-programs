#include <algorithm>
#include <charconv>
#include <format>
#include <iostream>
#include <ranges>
#include <string_view>
#include <vector>

namespace views = std::views;
namespace ranges = std::ranges;

struct Point {
    int x{}, y{};
    auto operator<=>(const Point&) const = default;
};

[[noreturn]] void usage() {
    std::cerr
        << R"(Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210"))"
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

auto to_sv = [](auto&& r) {
    return std::string_view{std::addressof(*ranges::begin(r)),
                            static_cast<std::size_t>(ranges::distance(r))};
};

auto parse_ints(std::string_view s) {
    return s | views::split(',') | views::transform(to_sv) |
           views::transform(trim) | views::transform(to_int);
}

std::vector<Point> parse_coordinates(std::string_view xs, std::string_view ys) {
    auto xv = parse_ints(xs);
    auto yv = parse_ints(ys);

    std::vector<Point> pts;

    auto xi = xv.begin();
    auto yi = yv.begin();

    for (; xi != xv.end() && yi != yv.end(); ++xi, ++yi) {
        if (!*xi || !*yi) usage();
        pts.emplace_back(**xi, **yi);
    }

    if (xi != xv.end() || yi != yv.end() || pts.size() < 3) usage();

    return pts;
}

constexpr long long orientation(Point a, Point b, Point c) noexcept {
    return 1LL * (b.x - a.x) * (c.y - a.y) - 1LL * (b.y - a.y) * (c.x - a.x);
}

template <ranges::input_range R>
std::vector<Point> build_half(R&& range) {
    std::vector<Point> hull;
    for (const auto& p : range) {
        while (hull.size() >= 2 &&
               orientation(hull[hull.size() - 2], hull.back(), p) <= 0) {
            hull.pop_back();
        }
        hull.push_back(p);
    }
    hull.pop_back();
    return hull;
}

std::vector<Point> convex_hull(std::vector<Point> pts) {
    ranges::sort(pts);
    auto [first, last] = ranges::unique(pts);
    pts.erase(first, last);

    if (pts.size() < 3) return pts;

    auto lower = build_half(pts);
    auto upper = build_half(pts | views::reverse);

    lower.insert(lower.end(), upper.begin(), upper.end());
    return lower;
}

int main(int argc, char* argv[]) {
    if (argc != 3) usage();

    auto points = parse_coordinates(argv[1], argv[2]);
    auto result = convex_hull(std::move(points));

    for (const auto& p : result) {
        std::cout << std::format("({}, {})\n", p.x, p.y);
    }
}