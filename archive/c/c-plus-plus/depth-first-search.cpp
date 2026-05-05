#include <algorithm>
#include <charconv>
#include <cmath>
#include <cstdint>
#include <format>
#include <iostream>
#include <optional>
#include <ranges>
#include <stack>
#include <string_view>
#include <vector>

namespace views = std::views;
namespace ranges = std::ranges;

[[noreturn]] void usage() {
    std::cerr
        << R"(Usage: please provide a tree in an adjacency matrix form ("0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0") together with a list of vertex values ("1, 3, 5, 2, 4") and the integer to find ("4"))"
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

bool can_reach_node(size_t start, int target,
                    const std::vector<int>& values,
                    const std::vector<int>& matrix) {
    const size_t n = values.size();
    if (n == 0) return false;

    std::vector<uint8_t> visited(n, 0);
    std::stack<size_t> st;
    st.push(start);

    while (!st.empty()) {
        size_t u = st.top();
        st.pop();

        if (visited[u]) continue;
        visited[u] = true;

        if (values[u] == target) return true;

        for (size_t v = 0; v < n; ++v) {
            if (matrix[u * n + v] != 0 && !visited[v]) {
                st.push(v);
            }
        }
    }
    return false;
}

int main(int argc, char* argv[]) {
    if (argc != 4) usage();

    auto parse_vec = [](std::string_view input) -> std::vector<int> {
        auto ints_view = input | views::split(',') | views::transform(to_sv) |
                         views::transform(trim) | views::transform(to_int);

        std::vector<int> numbers;
        numbers.reserve(ranges::distance(ints_view));

        for (auto v : ints_view) {
            if (!v) usage();
            numbers.push_back(*v);
        }
        return numbers;
    };

    const auto matrix = parse_vec(argv[1]);
    const auto values = parse_vec(argv[2]);
    const auto target = to_int(argv[3]);
    
    if (!target || values.empty()) usage();

    const std::size_t n = values.size();
    if (matrix.size() != n * n) usage();

    const bool reached = can_reach_node(0, *target, values, matrix);
    std::cout << std::format("{}\n", reached);
}