#include <charconv>
#include <iostream>
#include <optional>
#include <ranges>
#include <string_view>
#include <utility>
#include <vector>

namespace ranges = std::ranges;
namespace views = std::views;

[[noreturn]] void usage() {
    std::cout << "Usage: please enter the dimension of the matrix and the "
                 "serialized matrix\n";
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

std::optional<int> to_positive_int(std::string_view s) {
    int value{};
    auto [ptr, ec] = std::from_chars(s.data(), s.data() + s.size(), value);
    return (ec == std::errc{} && ptr == s.data() + s.size() && value > 0)
               ? std::make_optional(value)
               : std::nullopt;
}

std::optional<std::vector<int>> parse_vec(std::string_view s) {
    auto pipe = s | views::split(',') | views::transform([](auto&& r) {
                    return std::string_view{
                        std::addressof(*ranges::begin(r)),
                        static_cast<std::size_t>(ranges::distance(r))};
                }) |
                views::transform(trim) | views::transform(to_positive_int);

    std::vector<int> out;
    for (auto&& opt : pipe) {
        if (!opt) return std::nullopt;
        out.push_back(*opt);
    }
    return out.size() < 2 ? std::nullopt : std::make_optional(out);
}

std::vector<int> transpose(int rows, int cols, const std::vector<int>& m) {
    std::vector<int> out(rows * cols);

    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            out[j * rows + i] = m[i * cols + j];
        }
    }

    return out;
}

int main(int argc, char* argv[]) {
    if (argc != 4) usage();

    const auto cols = to_positive_int(argv[1]);
    const auto rows = to_positive_int(argv[2]);
    if (!cols || !rows) usage();

    std::string_view input = argv[3];
    if (input.empty()) usage();

    const int total = (*rows) * (*cols);

    auto matrix = parse_vec(input);
    if (!matrix) usage();

    if (matrix->size() != static_cast<std::size_t>(total)) usage();

    auto result = transpose(*rows, *cols, *matrix);

    for (const char* sep = ""; int val : result) {
        std::cout << std::exchange(sep, ", ") << val;
    }
    std::cout << "\n";
}